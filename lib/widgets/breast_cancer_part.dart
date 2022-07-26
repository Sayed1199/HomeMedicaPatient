import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/breast_cancer_modal_bottom_sheet.dart';

class BreastCancerPart extends StatefulWidget {
  const BreastCancerPart({Key? key}) : super(key: key);

  @override
  State<BreastCancerPart> createState() => _BreastCancerPartState();
}

class _BreastCancerPartState extends State<BreastCancerPart> {

  ThemeController themeController = Get.put(ThemeController());
  String bullet = "\u2022 ";

  List<String> testParameters=[
    "1. Radius Mean",
    "2. Texture Mean",
    "3. Perimeter Mean",
    "4. Area Mean",
    "5. Smoothness Mean",
    "6. Compactness Mean",
  "7. Concavity Mean",
  "8. Concave Points Mean",
  "9. Symmetry Mean",
  "10. Radius SE",
  "11. Perimeter SE",
  "12. Area SE",
  "13. Compactness SE",
  "14. Concavity SE",
  "15. Concave Points SE",
  "16. Fractal Dimension SE",
  "17. Radius Worst",
  "18. Texture Worst",
  "19. Perimeter Worst",
  "20. Area Worst",
  "21. Smoothness Worst",
  "22. Compactness Worst",
  "23. Concavity Worst",
  "24. Concave Points Worst",
  "25. Symmetry Worst",
    "26. Fractal Dimension Worst",
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
              header: Text("Breast Cancer",style: GoogleFonts.lato(
                  fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                  fontWeight: FontWeight.w600
              ),),
              collapsed: Center(
                child: TextButton(onPressed: showBreastcancerModalSheet, child: Text("Predict",style: GoogleFonts.lato(
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
                    child: Text("Breast cancer is cancer that forms in the cells of the breasts. "
                        "After skin cancer, breast cancer is the most common cancer diagnosed in women in the United States."
                        " Breast cancer can occur in both men and women, but it's far more common in women.",
                      style: serviceHeaderDefinitionStyle,),),

                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Symptoms",style:servicesHeaderStyle),
                  ),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("$bullet A breast lump or thickening that feels different from the surrounding tissue.\n"
                        "$bullet Change in the size, shape or appearance of a breast.\n"
                        "$bullet Changes to the skin over the breast, such as dimpling."
                        "\n$bullet Redness or pitting of the skin over your breast, like the skin of an orange.",style: serviceHeaderDefinitionStyle),),

                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Test parameters",style: servicesHeaderStyle),
                  ),



                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[0],style: parametersHeaderStyle,),),


                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[1],style: parametersHeaderStyle,),),


                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[2],style: parametersHeaderStyle,),),



                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[3],style: parametersHeaderStyle,),),


                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[4],style: parametersHeaderStyle,),),


                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[5],style: parametersHeaderStyle,),),



                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[6],style: parametersHeaderStyle,),),



                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[7],style: parametersHeaderStyle,),),


                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[8],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[9],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[10],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[11],style: parametersHeaderStyle,),),


                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[12],style: parametersHeaderStyle,),),


                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[13],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[14],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[15],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[16],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[17],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[18],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[19],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[20],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[21],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[22],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[23],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[24],style: parametersHeaderStyle,),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(testParameters[25],style: parametersHeaderStyle,),),



                  SizedBox(height: 20,),

                ],
              ),
            ),
          )

          ),
      ),
    );
  }

  void showBreastcancerModalSheet() {

    showModalBottomSheet(context: context,
        //backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return Container(
              height: MediaQuery.of(context).size.height*0.75,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: BreastCancerModalBottomSheet(),
              ));
        });

  }
}
