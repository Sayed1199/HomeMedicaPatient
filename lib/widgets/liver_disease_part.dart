import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/liver_disease_modal_bottom_sheet.dart';
class LiverDiseasePart extends StatefulWidget {
  const LiverDiseasePart({Key? key}) : super(key: key);

  @override
  State<LiverDiseasePart> createState() => _LiverDiseasePartState();
}

class _LiverDiseasePartState extends State<LiverDiseasePart> {



  ThemeController themeController = Get.put(ThemeController());
  String bullet = "\u2022 ";

  List<String> testParameters=[
    "1. Age",
    "2. TB",
    "3. DB",
    "4. Alkphos",
    "5. Sgpt",
    "6. Sgot",
    "7. TP",
    "8. ALB",
    "9. A/R",
    "10. Gender"
  ];

  List<String> parameterDefinitions=[
    "age of the patient [years]",
    "Total Bilirubin",
    "Direct Bilirubin",
    "Alkphos: Alkaline Phosphotase",
    "Alanine Aminotransferase",
    "Aspartate Aminotransferase",
    "Total Protiens",
    "Albumin",
    "Albumin and Globulin Ratio",
    "Gender (female:0,male:1)"
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
              header: Text("Liver Disease",style: GoogleFonts.lato(
                  fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                  fontWeight: FontWeight.w600
              ),),
              collapsed: Center(
                child: TextButton(onPressed: showLiverDiseaseModalSheet, child: Text("Predict",style: GoogleFonts.lato(
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
                    child: Text("Patients with liver disease have been continuously increasing because of excessive consumption of alcohol,"
                        " inhale of harmful gases,"
                        " intake of contaminated food, pickles and drugs.",
                        style:serviceHeaderDefinitionStyle),),

                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Symptoms",style:servicesHeaderStyle),
                  ),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("$bullet Swelling of the abdomen and legs."
                        "\n$bullet Bruising easily.\n"
                        "$bullet changes in the color of your stool and urine."
                        "\n$bullet jaundice or yellowing of the skin and eyes",style: serviceHeaderDefinitionStyle),),

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

                  SizedBox(height: 20,),

                ],
              ),
            ),
          )

          ),
      ),
    );
  }

  void showLiverDiseaseModalSheet() {


    showModalBottomSheet(context: context,
        //backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return Container(
              height: MediaQuery.of(context).size.height*0.75,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: LiverDiseaseModalBottomSheet(),
              ));
        });


  }
}
