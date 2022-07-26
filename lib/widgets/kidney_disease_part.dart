import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/kidney_disease_modal_bottom_sheet.dart';
class KidneyDiseasePart extends StatefulWidget {
  const KidneyDiseasePart({Key? key}) : super(key: key);

  @override
  State<KidneyDiseasePart> createState() => _KidneyDiseasePartState();
}

class _KidneyDiseasePartState extends State<KidneyDiseasePart> {


  ThemeController themeController = Get.put(ThemeController());
  String bullet = "\u2022 ";

  List<String> testParameters=[
    "1. Age",
    "2. BP",
    "3. AL",
    "4. SU",
    "5. RBC",
    "6. PC",
    "7. PCC",
    "8. BA",
    "9. BGR",
    "10. BU",
    "11. SC",
    "12. POT",
    "13. WC",
    "14. HTN",
    "15. DM",
    "16. CAD",
    "17. PE",
    "18. ANE"
  ];

  List<String> parameterDefinitions=[
    "age of the patient [years]",
    "Blood Pressure (50 mmHg - 180 mmHg)",
    "Albumin with 6 distinct values (0-5)",
    "Sugar with 6 distinct values (0-5)",
    "Red Blood Cells (normal:0,abnormal:1)",
    "Pus Cell (normal:0,abnormal:1)",
    "Pus cell Clumps (present:1,notpresent:0)",
    "Bacteria (present:1,notpresent:0)",
    "Blood Glucose Random (22 mg/dl - 490 mg/dl)",
    "Blood Urea (1.5 mg/dl - 391 mg/dl)",
    "Serum Creatinine (0.4 mg/dl - 76 mg/dl)",
    "Potassium (2.5 mEq/l - 47 mEq/l)",
    "White Blood Cell Count (2200 - 26400 cells/cumm)",
    "Hypertension (yes:1,no:0)",
    "Diabetes Mellitus (yes:1,no:0)",
    "Coronary Artery Disease (yes:1,no:0)",
    "Pedal Edema (yes:1,no:0)",
    "Anemia (yes:1,no:0)"
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
              header: Text("Chronic Kidney Disease",style: GoogleFonts.lato(
                  fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                  fontWeight: FontWeight.w600
              ),),
              collapsed: Center(
                child: TextButton(onPressed: showKidneyDiseaseModalSheet, child: Text("Predict",style: GoogleFonts.lato(
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
                    child: Text("Chronic kidney disease, also called chronic kidney failure,"
                        " describes the gradual loss of kidney function."
                        " Your kidneys filter wastes and excess fluids from your blood,"
                        " which are then excreted in your urine."
                        " When chronic kidney disease reaches an advanced stage,"
                        " dangerous levels of fluid, electrolytes and wastes can build up in your body.",
                        style:serviceHeaderDefinitionStyle),),

                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Symptoms",style:servicesHeaderStyle),
                  ),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("$bullet Nausea."
                        "\n$bullet Vomiting.\n"
                        "$bullet Fatigue and weakness."
                        "\n$bullet Muscle twitches and cramps.",style: serviceHeaderDefinitionStyle),),

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

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[13],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[13],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[14],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[14],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[15],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[15],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[16],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[16],style: parameterDefinitionStyle),),

                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[17],style:parametersHeaderStyle),),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(parameterDefinitions[17],style: parameterDefinitionStyle),),


                  SizedBox(height: 20,),

                ],
              ),
            ),
          )

          ),
      ),
    );
  }

  void showKidneyDiseaseModalSheet() {


    showModalBottomSheet(context: context,
        //backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return Container(
              height: MediaQuery.of(context).size.height*0.75,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: KidneyDiseaseModalBottomSheet(),
              ));
        });


  }
}
