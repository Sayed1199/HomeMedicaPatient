import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/covid19_modal_bottom_sheet.dart';

class Covid19DiseasePart extends StatefulWidget {
  const Covid19DiseasePart({Key? key}) : super(key: key);

  @override
  State<Covid19DiseasePart> createState() => _Covid19DiseasePartState();
}

class _Covid19DiseasePartState extends State<Covid19DiseasePart> {

 
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
              header: Text("Covid19",style: GoogleFonts.lato(
                  fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                  fontWeight: FontWeight.w600
              ),),
              collapsed: Center(
                child: TextButton(onPressed: showCovid19DiseaseModalSheet, child: Text("Predict",style: GoogleFonts.lato(
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
                    child: Text("A new respiratory virus first identified in Wuhan, Hubei Province, China.",
                        style:serviceHeaderDefinitionStyle),),

                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Symptoms",style:servicesHeaderStyle),
                  ),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("$bullet Fever or chills."
                        "\n$bullet Cough.\n"
                        "$bullet Shortness of breath or difficulty breathing."
                        "\n$bullet Fatigue."
                        "\n$bullet Muscle or body aches."
                        "\n$bullet Headache."
                        "\n$bullet New loss of taste or smell."
                        "\n$bullet Sore throat."
                        "\n$bullet Congestion or runny nose."
                        "\n$bullet Nausea or vomiting."
                        "\n$bullet Diarrhea."
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

  void showCovid19DiseaseModalSheet() {

    showModalBottomSheet(context: context,
        //backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return Container(
              height: MediaQuery.of(context).size.height*0.3,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Covid19ModalBottomSheet(),
              ));
        });

  }
}



