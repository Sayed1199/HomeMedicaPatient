import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/heart_modal_bottom_sheet.dart';

class HeartDiseasePart extends StatefulWidget {
  const HeartDiseasePart({Key? key}) : super(key: key);

  @override
  State<HeartDiseasePart> createState() => _HeartDiseasePartState();
}

class _HeartDiseasePartState extends State<HeartDiseasePart> {

  ThemeController themeController = Get.put(ThemeController());
  String bullet = "\u2022 ";

  List<String> testParameters=[
    "1. Age",
    "2. Sex",
    "3. CP",
    "4. RestingBP",
    "5. Serum Cholestoral",
    "6. FastingBS",
    "7. RestingECG",
    "8. MaxHR",
    "9. ExerciseAngina",
    "10. OldPeak",
    "11. ST_Slope",
    "12. Number of Major Vessels colored by flourosopy",
    "13. target",
  ];

  List<String> parameterDefinitions=[
  "age of the patient [years]",
  "0 Female, 1 Male",
  "Chest pain Type (0-3)\n"
      "0 - TA Typical Angina\n1 - ATA Atypical Angina\n2 -  NAP Non-Anginal Pain\n3 - ASY Asymptomatic",
  "resting blood pressure [mm Hg]",
  "serum cholesterol [mm/dl]",
  "fasting blood sugar [1: if FastingBS > 120 mg/dl, 0: otherwise]",
  "resting electrocardiogram results \n 0: Normal,\n 1: having ST-T wave abnormality (T wave inversions and/or ST elevation or"
      " depression of > 0.05 mV)\n 2: showing probable or definite left ventricular hypertrophy by Estes' criteria]",
  "maximum heart rate achieved [Numeric value between 60 and 202]",
  "exercise-induced angina [0: NO, 1: YES]",
  "oldPeak = ST [Numeric value measured in depression]",
  " the slope of the peak exercise ST segment [0: upSloping, 1: flat, 2: downSloping]",
  "number of major vessels (0-3) colored by flourosopy",
  "thal: 0 = normal \n 1 = fixed defect\n 2 = reversable defect"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Obx(()=>
          ExpandablePanel(
              theme: ExpandableThemeData(
                  iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
              ),
              header: Text("Heart Disease",style: GoogleFonts.lato(
                  fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                  fontWeight: FontWeight.w600
              ),),
              collapsed: Center(
                child: TextButton(onPressed: showHeartDiseaseModalSheet, child: Text("Predict",style: GoogleFonts.lato(
                    fontSize: 20,
                    color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20,vertical: 10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))

                  ),
                ),
              ), expanded: SizedBox(
            height: MediaQuery.of(context).size.height*0.6,
            width: MediaQuery.of(context).size.width,
            child: CupertinoScrollbar(
              child: ListView(
                children: [

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Definition",style: servicesHeaderStyle,),
                  ),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Cardiovascular diseases (CVDs) are the number 1 cause of death globally, "
                        "taking an estimated 17.9 million lives each year,"
                        " which accounts for 31% of all deaths worldwide. Four out of 5CVD deaths are due to heart attacks and strokes,"
                        " and one-third of these deaths occur prematurely in people under 70 years of age."
                        " Heart failure is a common event caused by CVDs and this dataset contains 11 features"
                        " that can be used to predict a possible heart disease.",
                        style:serviceHeaderDefinitionStyle),),

                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Symptoms",style:servicesHeaderStyle),
                  ),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("$bullet Chest pain, chest tightness, chest pressure and chest discomfort (angina)."
                        "\n$bullet Shortness of breath.\n"
                        "$bullet Pain, numbness, weakness or coldness in your legs or arms if the blood vessels in those parts of your body are narrowed."
                        "\n$bullet Pain in the neck, jaw, throat, upper abdomen or back.",style: serviceHeaderDefinitionStyle),),

                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Test parameters",style: servicesHeaderStyle,),
                  ),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[0],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[0],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[1],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[1],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[2],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[2],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[3],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[3],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[4],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[4],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[5],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[5],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[6],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[6],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[7],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[7],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[8],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[8],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[9],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[9],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[10],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[10],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[11],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[11],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[12],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[12],style: parameterDefinitionStyle),),

                  SizedBox(height: 20,),

                ],
              ),
            ),
          )

          ),
      ),
    );
  }

  void showHeartDiseaseModalSheet() {



       showModalBottomSheet(context: context,
        //backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return Container(
              height: MediaQuery.of(context).size.height*0.75,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: HeartDiseaseModalBottomSheet(),
              ));
        });



  }
}




