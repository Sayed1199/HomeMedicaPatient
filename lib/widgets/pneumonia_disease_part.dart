import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/pneumonia_modal_bottom_sheet.dart';

class PneumoniaDiseasePart extends StatefulWidget {
  const PneumoniaDiseasePart({Key? key}) : super(key: key);

  @override
  State<PneumoniaDiseasePart> createState() => _PneumoniaDiseasePartState();
}

class _PneumoniaDiseasePartState extends State<PneumoniaDiseasePart> {

  ThemeController themeController = Get.put(ThemeController());
  String bullet = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Obx(()=>
          ExpandablePanel(
              theme: ExpandableThemeData(
                  iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
              ),
              header: Text("Pneumonia Disease",style: GoogleFonts.lato(
                  fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                  fontWeight: FontWeight.w600
              ),),
              collapsed: Center(
                child: TextButton(onPressed: showPneumoniaDiseaseModalSheet, child: Text("Predict",style: GoogleFonts.lato(
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
                    child: Text("Pneumonia is an infection that inflames the air sacs in one or both lungs."
                        " The air sacs may fill with fluid or pus (purulent material).",
                        style:serviceHeaderDefinitionStyle),),

                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Symptoms",style:servicesHeaderStyle),
                  ),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("$bullet Cough, which may produce greenish, yellow or even bloody mucus."
                        "\n$bullet Fever, sweating and shaking chills.\n"
                        "$bullet Shortness of breath."
                        "\n$bullet Rapid, shallow breathing."
                      ,style: serviceHeaderDefinitionStyle),),

                  SizedBox(height: 20,),

                ],
              ),
            ),
          )

          ),
      ),
    );
  }

  void showPneumoniaDiseaseModalSheet() {

    showModalBottomSheet(context: context,
        //backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return Container(
              height: MediaQuery.of(context).size.height*0.3,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: PneumoniaModalBottomSheet(),
              ));
        });


  }
}
