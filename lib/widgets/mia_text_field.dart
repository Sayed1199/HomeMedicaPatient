import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/mia_chat_controller.dart';
import 'package:homemedica_patient/controllers/mia_mic_controller.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/services/database.dart';
import 'package:homemedica_patient/services/infermedica_api.dart';


class BuildMiaTextField extends StatefulWidget {
  final MiaChatController chatsController;
  final FocusNode textFieldFocusNode;
  final TextEditingController textEditingController;

  const BuildMiaTextField(
      {Key? key,
      required this.chatsController,
      required this.textFieldFocusNode,
      required this.textEditingController})
      : super(key: key);

  @override
  _BuildMiaTextFieldState createState() => _BuildMiaTextFieldState();
}

class _BuildMiaTextFieldState extends State<BuildMiaTextField> {
  Database database = Database();
  bool isEnabled = true;
  InfermedicaApi infermedicaApi = InfermedicaApi();
  List<String> questionResponses = [];
  int ageNumber = 0;
  String gender = '';
  Map<String, dynamic> age = {};
  String text = '';
  late List<Map<String, dynamic>> parseEvidences;
  late Map<String, dynamic> diagnosis;
  ThemeController themeController = Get.put(ThemeController());
  MiaMicController micController = Get.put(MiaMicController());


  Widget _buildTextField() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 0, top: 5),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Obx(() =>
            TextField(
              maxLines: null,
              style: TextStyle(
                fontSize: 16,
              ),
              enabled: !chatController.isAiEnabled.value,
              textAlign: TextAlign.center,
              focusNode: widget.textFieldFocusNode,
              controller: widget.textEditingController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.send,
              cursorColor: Colors.blue,
              keyboardAppearance: Brightness.dark,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Send Smth...',
                hintStyle: TextStyle(
                  fontSize: 16,
                ),
              ),
              //onSubmitted: (_) => send(),
              onSubmitted: (_) {
                print("submit");
              },
            ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTextField(),
                SizedBox(width: 5,),
                Obx(() =>
                    Visibility(
                      visible: !chatController.isAiEnabled.value,
                      child: GestureDetector(

                        onTap: () {
                          if (micController.isMicopen.value == true) {
                            micController.closeMic();
                            widget.textEditingController.text = micController
                                .lastWords.value;
                          } else {
                            micController.openMic();
                          }
                        },

                        child: Obx(() =>
                            Icon(
                              micController.isMicopen.value == false
                                  ? FontAwesomeIcons.microphoneAltSlash
                                  : FontAwesomeIcons.microphoneAlt,
                              size: 20,
                              color: Colors.blueAccent.withOpacity(0.8),
                            ),
                        ),
                      ),
                    ),
                ),
                SizedBox(width: 5,),
                IconButton(
                    onPressed: () {
                      if (widget.textEditingController.text == '') {
                        Fluttertoast.showToast(
                            msg: "Cant reply w empty msg, sorry",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.blue,
                            gravity: ToastGravity.BOTTOM);
                      } else {
                        handleAi();
                        widget.textEditingController.text = '';
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.blueAccent.withOpacity(0.8),
                    )),
                SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void handleAi() async {
    if (widget.chatsController.messagesList.value[0].message ==
        askingAboutAge[0] ||
        widget.chatsController.messagesList.value[0].message ==
            askingAboutAge[1]) {
      try {
        String t = widget.textEditingController.text;
        if (t.contains("I am")) {
          t = t.replaceAll("I am", '');
        }
        if (t.contains("years")) {
          t = t.replaceAll("years", '');
        }
        if (t.contains("old")) {
          t = t.replaceAll("old", '');
        }
        print("t is: ${t}");
        ageNumber = int.parse(t);
        age = {'value': ageNumber, 'unit': 'year'};
        widget.chatsController.sendUserMessage(
            widget.textEditingController.text);
        await widget.chatsController.sendAiMessage(genderSentence);
      } catch (error) {
        await widget.chatsController.sendAiMessage(wrongAgeAnswer);

        await  widget.chatsController.sendAiMessage(
            askingAboutAge[Random().nextInt(askingAboutAge.length)]);
      }
    } else if (widget.chatsController.messagesList.value[0].message ==
        genderSentence) {
      String temp = widget.textEditingController.text;
      if (SexNorm.containsKey(temp)) {
        gender = SexNorm[temp]!;
        widget.chatsController.sendUserMessage(
            widget.textEditingController.text);
       await widget.chatsController.sendAiMessage(symptomsSentence);
      } else {

        await widget.chatsController.sendAiMessage(wrongGenderAnswer);

        await widget.chatsController.sendAiMessage(genderSentence);
      }
    } else if (widget.chatsController.messagesList.value[0].message ==
        symptomsSentence) {
      text = widget.textEditingController.text;
      widget.chatsController.sendUserMessage(text);

      await widget.chatsController.sendAiMessage(waitSentence);

      print('age: ${age}');
      print('gender: ${gender}');
      print('text: ${text}');

      Map<String, dynamic> parse = await infermedicaApi.callParse(
          age,
          gender,
          text,
          dotenv.env['APPID']!,
          dotenv.env['APPKEY']!,
          'u1',
          [],
          null);

      parseEvidences =
          infermedicaApi.convertParseMentionsToEvidences(parse['mentions']);

      diagnosis = await infermedicaApi.callDiagnosis(
          parseEvidences,
          age,
          gender,
          'u',
          dotenv.env['APPID']!,
          dotenv.env['APPKEY']!,
          false,
          null);

      print('Diagnosis:\n ${diagnosis}');


      if (diagnosis['should_stop'] == true) {
        print('should Stop : right');
        String conditions = '';
        List<dynamic> conditionsList = diagnosis['conditions'];
        conditionsList.forEach((element) {
          conditions +=
          ('${element['name']} with probability ${element['probability']} \n');
        });
        await widget.chatsController.sendAiMessage(conditions);
      } else {
        ///////////////////////////////////////////////

        print('entered dialog');

        FocusScope.of(context).requestFocus(FocusNode());
        SystemChannels.textInput.invokeMethod('TextInput.hide');

        while (diagnosis['should_stop'] == false) {
          print('diagnosis: ${diagnosis}');

          if (diagnosis['question']['type'] == 'single') {
            await Get.defaultDialog(
                backgroundColor: Colors.transparent,
                title: 'Question',
                titlePadding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                titleStyle: GoogleFonts.lato(fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.pinkAccent),
                barrierDismissible: false,
                content: Text(
                    diagnosis['question']['text'], textAlign: TextAlign.center,
                    style: GoogleFonts.actor(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: themeController.isDarkModeEnabled.value ? Colors
                            .grey[100] : Colors.grey[900]
                    )),
                actions: [

                  TextButton(onPressed: () async {
                    parseEvidences.add(
                        {
                          'id': diagnosis['question']["items"][0]["id"],
                          'choice_id': diagnosis["question"]["items"][0]["choices"][0]["id"]
                        });

                    diagnosis = await infermedicaApi.callDiagnosis(
                        parseEvidences,
                        age,
                        gender,
                        'u',
                        dotenv.env['APPID']!,
                        dotenv.env['APPKEY']!,
                        false,
                        null);

                    Get.back();
                  }, child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                      child: Text('Yes', style:
                      GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: themeController.isDarkModeEnabled.value ?
                          Colors.grey[100]
                              : Colors.grey[900]
                      ),),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green,
                    ),
                  ),
                  ),

                  TextButton(onPressed: () async {
                    parseEvidences.add(
                        {
                          'id': diagnosis['question']["items"][0]["id"],
                          'choice_id': diagnosis["question"]["items"][0]["choices"][1]["id"]
                        });

                    diagnosis = await infermedicaApi.callDiagnosis(
                        parseEvidences,
                        age,
                        gender,
                        'u',
                        dotenv.env['APPID']!,
                        dotenv.env['APPKEY']!,
                        false,
                        null);


                    Get.back();
                  }, child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                      child: Text('No', style:
                      GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: themeController.isDarkModeEnabled.value ?
                          Colors.grey[100]
                              : Colors.grey[900]
                      ),),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.pinkAccent,
                    ),
                  ),
                  ),

                  TextButton(onPressed: () async {
                    parseEvidences.add(
                        {
                          'id': diagnosis['question']["items"][0]["id"],
                          'choice_id': diagnosis["question"]["items"][0]["choices"][2]["id"]
                        });

                    diagnosis = await infermedicaApi.callDiagnosis(
                        parseEvidences,
                        age,
                        gender,
                        'u',
                        dotenv.env['APPID']!,
                        dotenv.env['APPKEY']!,
                        false,
                        null);


                    Get.back();
                  }, child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                      child: Text("Don't Know", style:
                      GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: themeController.isDarkModeEnabled.value ?
                          Colors.grey[100]
                              : Colors.grey[900]
                      ),),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.orange,
                    ),
                  ),
                  ),

                ]
            );
          } else if (diagnosis['question']['type'] == 'group_single') {
            for (int i = 0; i < diagnosis['question']['items'].length; i++) {
              await Get.defaultDialog(
                  backgroundColor: Colors.transparent,
                  title: diagnosis['question']['text'],
                  titlePadding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  titleStyle: GoogleFonts.lato(fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.pinkAccent),
                  barrierDismissible: false,
                  content: Text(diagnosis['question']['items'][i]['name'],
                      textAlign: TextAlign.center, style: GoogleFonts.actor(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: themeController.isDarkModeEnabled.value
                              ? Colors.grey[100]
                              : Colors.grey[900]
                      )),
                  actions: [

                    TextButton(onPressed: () async {
                      parseEvidences.add(
                          {
                            'id': diagnosis['question']["items"][i]["id"],
                            'choice_id': diagnosis["question"]["items"][i]["choices"][0]["id"]
                          });

                      diagnosis = await infermedicaApi.callDiagnosis(
                          parseEvidences,
                          age,
                          gender,
                          'u',
                          dotenv.env['APPID']!,
                          dotenv.env['APPKEY']!,
                          false,
                          null);


                      Get.back();
                    }, child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                        child: Text('Yes', style:
                        GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: themeController.isDarkModeEnabled.value ?
                            Colors.grey[100]
                                : Colors.grey[900]
                        ),),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green,
                      ),
                    ),
                    ),

                    TextButton(onPressed: () async {
                      parseEvidences.add(
                          {
                            'id': diagnosis['question']["items"][i]["id"],
                            'choice_id': diagnosis["question"]["items"][i]["choices"][1]["id"]
                          });

                      diagnosis = await infermedicaApi.callDiagnosis(
                          parseEvidences,
                          age,
                          gender,
                          'u',
                          dotenv.env['APPID']!,
                          dotenv.env['APPKEY']!,
                          false,
                          null);


                      Get.back();
                    }, child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                        child: Text('No', style:
                        GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: themeController.isDarkModeEnabled.value ?
                            Colors.grey[100]
                                : Colors.grey[900]
                        ),),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.pinkAccent,
                      ),
                    ),
                    ),

                    TextButton(onPressed: () async {
                      parseEvidences.add(
                          {
                            'id': diagnosis['question']["items"][i]["id"],
                            'choice_id': diagnosis["question"]["items"][i]["choices"][2]["id"]
                          });

                      diagnosis = await infermedicaApi.callDiagnosis(
                          parseEvidences,
                          age,
                          gender,
                          'u',
                          dotenv.env['APPID']!,
                          dotenv.env['APPKEY']!,
                          false,
                          null);

                      Get.back();
                    }, child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                        child: Text("Don't Know", style:
                        GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: themeController.isDarkModeEnabled.value ?
                            Colors.grey[100]
                                : Colors.grey[900]
                        ),),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.orange,
                      ),
                    ),
                    ),

                  ]
              );
            }
          } else {
            for (int i = 0; i < diagnosis['question']['items'].length; i++) {
              await Get.defaultDialog(
                  backgroundColor: Colors.transparent,
                  title: diagnosis['question']['text'],
                  titlePadding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  titleStyle: GoogleFonts.lato(fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.pinkAccent),
                  barrierDismissible: false,
                  content: Text(diagnosis['question']['items'][i]['name'],
                      textAlign: TextAlign.center, style: GoogleFonts.actor(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: themeController.isDarkModeEnabled.value
                              ? Colors.grey[100]
                              : Colors.grey[900]
                      )),
                  actions: [

                    TextButton(onPressed: () async {
                      parseEvidences.add(
                          {
                            'id': diagnosis['question']["items"][i]["id"],
                            'choice_id': diagnosis["question"]["items"][i]["choices"][0]["id"]
                          });

                      diagnosis = await infermedicaApi.callDiagnosis(
                          parseEvidences,
                          age,
                          gender,
                          'u',
                          dotenv.env['APPID']!,
                          dotenv.env['APPKEY']!,
                          false,
                          null);

                      Get.back();
                    }, child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                        child: Text('Yes', style:
                        GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: themeController.isDarkModeEnabled.value ?
                            Colors.grey[100]
                                : Colors.grey[900]
                        ),),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green,
                      ),
                    ),
                    ),

                    TextButton(onPressed: () async {
                      parseEvidences.add(
                          {
                            'id': diagnosis['question']["items"][i]["id"],
                            'choice_id': diagnosis["question"]["items"][i]["choices"][1]["id"]
                          });

                      diagnosis = await infermedicaApi.callDiagnosis(
                          parseEvidences,
                          age,
                          gender,
                          'u',
                          dotenv.env['APPID']!,
                          dotenv.env['APPKEY']!,
                          false,
                          null);


                      Get.back();
                    }, child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                        child: Text('No', style:
                        GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: themeController.isDarkModeEnabled.value ?
                            Colors.grey[100]
                                : Colors.grey[900]
                        ),),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.pinkAccent,
                      ),
                    ),
                    ),

                    TextButton(onPressed: () async {
                      parseEvidences.add(
                          {
                            'id': diagnosis['question']["items"][i]["id"],
                            'choice_id': diagnosis["question"]["items"][i]["choices"][2]["id"]
                          });

                      diagnosis = await infermedicaApi.callDiagnosis(
                          parseEvidences,
                          age,
                          gender,
                          'u',
                          dotenv.env['APPID']!,
                          dotenv.env['APPKEY']!,
                          false,
                          null);

                      Get.back();
                    }, child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                        child: Text("Don't Know", style:
                        GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: themeController.isDarkModeEnabled.value ?
                            Colors.grey[100]
                                : Colors.grey[900]
                        ),),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.orange,
                      ),
                    ),
                    ),

                  ]
              );
            }
          }
        }

        /// end whileeeee

        String conditions = '';
        List<dynamic> conditionsList = diagnosis['conditions'];
        conditionsList.forEach((element) {
          conditions +=
          ('your symptoms led to: \n ${element['name']} with probability ${element['probability']} \n');
        });

       await widget.chatsController.sendAiMessage(conditions);


        await widget.chatsController.sendAiMessage(askForBooking);
      }

        ///////////////////////////////////////////////

      }else if(widget.chatsController.messagesList.value[0].message==askForBooking){

      String text = widget.textEditingController.text;
      if(AnswerNorm.containsKey(text)){

        widget.chatsController.sendUserMessage(text);
        if(AnswerNorm[text]=="present"){
          print('Navigating to booking Screen');
          /////////////////////
        }else{
          await widget.chatsController.sendAiMessage("GoodBye sir i was happy to serve you.");
        }

      }

    }



    }
  }
