import 'dart:convert';
import 'package:http/http.dart' as http;


  class InfermedicaApi {

    Map<String, String> getHeaders(String appID, String appKey, String? caseID,
        String? ln) {
      Map<String, String> mMap = {
        'Content-Type': 'application/json',
        'Dev-Mode': 'true', // please turn this off when your app goes live
        'Interview-Id': caseID!,
        'App-Id': appID,
        'App-Key': appKey,
      };

      if (ln != null) {
        mMap['Model'] = ln;
      }

      return mMap;
    }

    Future<Map<String, dynamic>> callEndPoint(String endPoint, String appID,
        String appKey, Map<String, dynamic>? requestSpec, String? caseID,
        String? ln) async {
      String lang_code = '';
      http.Response resp;

      String url = 'https://api.infermedica.com/v3/${endPoint}';
      Map<String, String> headers = getHeaders(appID, appKey, caseID, ln);

      if (ln != null) {
        if (ln.contains('-')) {
          lang_code = ln.split('-')[-1];
        } else {
          lang_code = ln;
        }
      }

      headers['Language'] = lang_code;

      if (requestSpec != null) {
        resp = await http.post(
            Uri.parse(url), headers: headers, body: jsonEncode(requestSpec));
      } else {
        resp = await http.get(Uri.parse(url), headers: headers);
      }

      return jsonDecode(resp.body);
    }

    //parsing text

    Future<Map<String,dynamic>> callParse(Map<String, dynamic> age, String sex,
        String text, String appID, String appKey, String? caseID,
        List<String>? context, String? ln) async {
      Map<String, dynamic> requestSpec = {
        'age': age,
        'sex': sex,
        'text': text,
        'context': context,
        'include_tokens': true,
        'concept_types': ['symptom', 'risk_factor'],
      };
      return callEndPoint('parse', appID, appKey, requestSpec, caseID, ln);
    }

    // convert parse mentions to evidences

    List<Map<String,dynamic>> convertParseMentionsToEvidences(List<dynamic> mentions){

      List<Map<String,dynamic>> mList=[];
      mentions.forEach((element) {
        mList.add({
          'id':element['id'],
          'choice_id':element['choice_id'],
          'source':'initial'
        });
      });
      return mList;
    }

    // diagnosis

    Future<Map<String,dynamic>> callDiagnosis(List<Map<String,dynamic>> evidences, Map<String,dynamic> age, String sex,
        String? caseID,String appID,String appKey, bool noGroups,String? ln)async{


      Map<String,dynamic> requestSpec ={
        'age': age,
        'sex': sex,
        'evidence': evidences,
        'extras': {
          'disable_groups':noGroups
        },
      };

      return await callEndPoint('diagnosis', appID, appKey, requestSpec, caseID, ln);

    }



    void run() async {
      List<Map<String, String>> mEvidence = [
        {
          "id": "s_1193",
          "choice_id": "present",
        },
        {
          "id": "s_488",
          "choice_id": "present"
        },
        {
          "id": "s_418",
          "choice_id": "present"
        }
      ];

      Map<String, dynamic> age = {'value': 30, 'unit': 'year'};
      String sex = 'male';
      List<Map<String, dynamic>> mentions = [
        {
          'id': 'p_8',
          'name': 'Diagnosed diabetes',
          'common_name': 'Diagnosed diabetes',
          'orth': 'Diabetes',
          'choice_id': 'present',
          'type': 'risk_factor',
          'positions': [2],
          'head_position': 2
        }
      ];
      dynamic question = {
        'question': {'type': 'single', 'text': 'Do you have a fever?',
          'items': [
            {
              'id': 's_98',
              'name': 'Fever',
              'choices': [
                {'id': 'present', 'label': 'Yes'},
                {'id': 'absent', 'label': 'No'},
                {'id': 'unknown', 'label': "Don't know"}
              ]
            }
          ],
          'extras': {}},
      } as dynamic;

      String text = 'I feel sad';

    /*
      Map<String,dynamic> parse = await callParse(age, sex, text, appID, appKey, 'u1', [], null);
      print('parse: $parse');
      print('////////////////////////////\n/////////////////////\n///////////////');
      List<Map<String,dynamic>> parseEvidences = convertParseMentionsToEvidences(parse['mentions']);
      print('parseEvidences: $parseEvidences');
      print('////////////////////////////\n/////////////////////\n///////////////');
      Map<String,dynamic> diagnosis = await callDiagnosis(parseEvidences, age, sex, 'u', appID, appKey, false, null);
      print('diagnosis1: $diagnosis');
      print('shouldStop1: ${diagnosis['should_stop']}');
      print('////////////////////////////\n/////////////////////\n///////////////');
      while(diagnosis['should_stop'] != true){
        parseEvidences.add(
            {
              'id':diagnosis['question']["items"][0]["id"],
              'choice_id': diagnosis["question"]["items"][0]["choices"][0]["id"]
            }
        );
        diagnosis = await callDiagnosis(parseEvidences, age, sex, 'u', appID, appKey, false, null);
        print('diagnosis2: $diagnosis');
        print('shouldStop2: ${diagnosis['should_stop']}');
        print('////////////////////////////\n/////////////////////\n///////////////');
      }

      print('Conditions: ${diagnosis['conditions'][0]['name']}---${diagnosis['conditions'][0]['probability']}');


     */

      /*

      parse: {mentions: [{id: s_169, name: Depressed mood, common_name: Depressed mood, orth: I feel sad, choice_id: present, type: symptom, positions: [0, 1, 2], head_position: 1}], obvious: true, tokens: [I, feel, sad]}
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): parseEvidences: [{id: s_169, choice_id: present, source: initial}]
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis1: {question: {type: single, text: Have you been feeling depressed for more than 2 weeks without improvement?, items: [{id: s_916, name: Depressed mood, more than 2 weeks, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_26, name: Major depressive disorder, common_name: Depression, probability: 0.0265}], extras: {}, has_emergency_evidence: false, should_stop: false}
I/flutter (14704): shouldStop1: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: single, text: Have you ever had a diagnosed depressive episode?, items: [{id: p_171, name: History of depressive episode, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_26, name: Major depressive disorder, common_name: Depression, probability: 0.3986}], extras: {}, has_emergency_evidence: false, should_stop: false}
I/flutter (14704): shouldStop2: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: single, text: Have you had thoughts about hurting yourself, or have you done it?, items: [{id: s_2213, name: Self-injurious thoughts or behaviours, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_26, name: Major depressive disorder, common_name: Depression, probability: 0.4932}, {id: c_320, name: Seasonal affective disorder, common_name: Seasonal affective disorder, probability: 0.2788}, {id: c_273, name: Bipolar disorder, common_name: Bipolar disorder, probability: 0.0627}], extras: {}, has_emergency_evidence: false, should_stop: false}
I/flutter (14704): shouldStop2: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: single, text: Have you recently intentionally hurt yourself?, items: [{id: s_2228, name: Self-injurious behaviour, recent, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_26, name: Major depressive disorder, common_name: Depression, probability: 0.5525}, {id: c_320, name: Seasonal affective disorder, common_name: Seasonal affective disorder, probability: 0.3786}, {id: c_273, name: Bipolar disorder, common_name: Bipolar disorder, probability: 0.0961}], extras: {}, has_emergency_evidence: false, should_stop: false}
I/flutter (14704): shouldStop2: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: group_single, text: How would you describe the self-inflicted injuries?, items: [{id: s_2229, name: Minor, e.g., small cuts, scratches, or bruises, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_2230, name: Major, e.g.,  deep bleeding cuts, severe wounds, or serious injury, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_26, name: Major depressive disorder, common_name: Depression, probability: 0.5664}, {id: c_320, name: Seasonal affective disorder, common_name: Seasonal affective disorder, probability: 0.3881}, {id: c_273, name: Bipolar disorder, common_name: Bipolar disorder, probability: 0.1008}], extras: {}, has_emergency_evidence: false, should_stop: false}
I/flutter (14704): shouldStop2: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: group_multiple, text: Which of the following thoughts or behaviours apply to you?, items: [{id: s_69, name: Frequently having intrusive thoughts about food, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_2473, name: Obsessing about getting huge muscles, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_243, name: Losing weight through vomiting, starvation, exercising intensely, or using laxatives or diuretics, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_423, name: Believing that self-worth depends on weight, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_157, name: Fear of gaining weight or becoming obese, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_2470, name: Fear of getting old, choices:
I/flutter (14704): shouldStop2: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: group_multiple, text: Which of the following thoughts or behaviours apply to you?, items: [{id: s_2473, name: Obsessing about getting huge muscles, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_243, name: Losing weight through vomiting, starvation, exercising intensely, or using laxatives or diuretics, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_423, name: Believing that self-worth depends on weight, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_157, name: Fear of gaining weight or becoming obese, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_2470, name: Fear of getting old, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_26, name: Major depressive disorder, comm
I/flutter (14704): shouldStop2: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: group_multiple, text: Which of the following thoughts or behaviours apply to you?, items: [{id: s_243, name: Losing weight through vomiting, starvation, exercising intensely, or using laxatives or diuretics, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_423, name: Believing that self-worth depends on weight, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_157, name: Fear of gaining weight or becoming obese, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_2470, name: Fear of getting old, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_26, name: Major depressive disorder, common_name: Depression, probability: 0.7839}, {id: c_320, name: Seasonal affective disorder, common_name: Seasonal affective disorder, probability: 0.2041}],
I/flutter (14704): shouldStop2: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: single, text: Do you repetitively binge eat, significantly overeat, or feel like you can't control how much you eat?, items: [{id: s_137, name: Binge eating, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_26, name: Major depressive disorder, common_name: Depression, probability: 0.7101}, {id: c_14, name: Bulimia nervosa, common_name: Bulimia, probability: 0.3371}, {id: c_320, name: Seasonal affective disorder, common_name: Seasonal affective disorder, probability: 0.2533}, {id: c_7, name: Anorexia nervosa, common_name: Anorexia nervosa, probability: 0.1789}], extras: {}, has_emergency_evidence: false, should_stop: false}
I/flutter (14704): shouldStop2: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: group_multiple, text: Which of the following thoughts or behaviours apply to you?, items: [{id: s_568, name: Feeling disgusted with oneself after binge eating, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_423, name: Believing that self-worth depends on weight, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_157, name: Fear of gaining weight or becoming obese, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_2470, name: Fear of getting old, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_26, name: Major depressive disorder, common_name: Depression, probability: 0.6467}, {id: c_14, name: Bulimia nervosa, common_name: Bulimia, probability: 0.5131}, {id: c_320, name: Seasonal affective disorder, common_name: Seasonal affective dis
I/flutter (14704): shouldStop2: false
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): diagnosis2: {question: {type: group_multiple, text: Which of the following gastric symptoms, if any, do you have?, items: [{id: s_156, name: Feeling queasy or nauseous, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_305, name: Vomiting, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}, {id: s_8, name: Diarrhea, 3 or more watery stools a day, choices: [{id: present, label: Yes}, {id: absent, label: No}, {id: unknown, label: Don't know}]}], extras: {}}, conditions: [{id: c_14, name: Bulimia nervosa, common_name: Bulimia, probability: 0.8344}, {id: c_26, name: Major depressive disorder, common_name: Depression, probability: 0.5999}, {id: c_320, name: Seasonal affective disorder, common_name: Seasonal affective disorder, probability: 0.3363}], extras: {}, has_emergency_evidence: false, should_stop: true}
I/flutter (14704): shouldStop2: true
I/flutter (14704): ////////////////////////////
I/flutter (14704): /////////////////////
I/flutter (14704): ///////////////
I/flutter (14704): Conditions: Bulimia nervosa---0.8344


       */


    }
  }


