import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/diabetes_modal_bottom_sheet.dart';


class DiabetesPart extends StatefulWidget {
  const DiabetesPart({Key? key}) : super(key: key);

  @override
  State<DiabetesPart> createState() => _DiabetesPartState();
}

class _DiabetesPartState extends State<DiabetesPart> {

  ThemeController themeController = Get.put(ThemeController());
  String bullet = "\u2022 ";

  List<String> testParameters=[
    "1. Number of Pregnancies",
    "2. Glucose",
    "3. Blood Pressure",
    "4. Skin Thickness",
    "5. Insulin Level",
    "6. Body Mass Index",
    "7. Diabetes Pedigree Function",
    "8. Age"
  ];

  List<String> parameterDefinitions=[
    "Frequency of pregnancy",
    "Concentration of plasma glucose (mg/dL)",
    "Diastolic blood pressure (mm Hg)",
    "Tricep skinfold thickness (mm)",
    "Two-hour serum insulin (mu U/ml)",
    "Body mass index (kg/m2)",
    "A pedigree function for diabetes",
    "Age (log (years))"
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
              header: Text("Diabetes",style: GoogleFonts.lato(
                  fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                  fontWeight: FontWeight.w600
              ),),
              collapsed: Center(
                child: TextButton(onPressed: showDiabetesModalSheet, child: Text("Predict",style: GoogleFonts.lato(
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
            height: MediaQuery.of(context).size.height*0.8,
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
                    child: Text("Diabetes is a disease that occurs when your blood glucose,"
                        " also called blood sugar, is too high. Blood glucose is your main source of energy and comes from the food you eat."
                        " Insulin, a hormone made by the pancreas, helps glucose from food get into your cells to be used for energy."
                        " Sometimes your body doesn’t make enough—or any—insulin or doesn’t use insulin well. Glucose then stays in your blood "
                        "and doesn’t reach your cells.",style:serviceHeaderDefinitionStyle),),

                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Symptoms",style:servicesHeaderStyle),
                  ),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("$bullet Urinating often.\n$bullet Feeling very thirsty.\n"
                        "$bullet Extreme fatigue.\n$bullet Blurry vision.",style: serviceHeaderDefinitionStyle),),

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

                  SizedBox(height: 20,),

                ],
              ),
            ),
          )

          ),
      ),
    );
  }

  void showDiabetesModalSheet() {

    showModalBottomSheet(context: context,
        //backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return Container(
              height: MediaQuery.of(context).size.height*0.75,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: DiabetesModalBottomSheet(),
              ));
        });


  }

}
