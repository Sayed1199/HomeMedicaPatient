import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/services/home_medica_api.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:homemedica_patient/widgets/service_dialog.dart';
import 'package:homemedica_patient/widgets/text_field_widget.dart';
class LiverDiseaseModalBottomSheet extends StatefulWidget {
  const LiverDiseaseModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<LiverDiseaseModalBottomSheet> createState() => _LiverDiseaseModalBottomSheetState();
}

class _LiverDiseaseModalBottomSheetState extends State<LiverDiseaseModalBottomSheet> {

  TextEditingController ageController = TextEditingController();
  TextEditingController tBController = TextEditingController();
  TextEditingController dBController = TextEditingController();
  TextEditingController aPController = TextEditingController();
  TextEditingController alamineController = TextEditingController();
  TextEditingController aspartateController = TextEditingController();
  TextEditingController totalProteinsController = TextEditingController();
  TextEditingController albuminController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController albuminAndGlobulinController = TextEditingController();



  ThemeController themeController = Get.put(ThemeController());

  bool isLoading = false;

  List<String> testParameters=[
    "Age",
    "TB",
    "DB",
    "Alkphos",
    "Sgpt",
    "Sgot",
    "TP",
    "ALB",
    "A/R",
    "Gender"
  ];

  List<String> parameterDefinitions=[
    "(integer)",
    "(number)",
    "(number)",
    "(number)",
    "(number)",
    "(number)",
    "(number)",
    "(integer)",
    "(number)",
    "(number)(Female:0,Male:1)"
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    ageController.dispose();
    tBController.dispose();
    dBController.dispose();
    aPController.dispose();
    alamineController.dispose();
    aspartateController.dispose();
    totalProteinsController.dispose();
    albuminController.dispose();
    albuminAndGlobulinController.dispose();
    genderController.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: isLoading?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingWidget(),
            SizedBox(height: 20,),
            Text("Please Wait...",style: GoogleFonts.lato(
                fontSize: 22,
                color: Colors.blue
            ),),
          ],
        ) :CupertinoScrollbar(
          child: ListView(
            children: [

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: ageController,
                      text: testParameters[0], hinttext: parameterDefinitions[0],
                      themeController: themeController,isInteger: false,),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: tBController,
                      text: testParameters[1], hinttext: parameterDefinitions[1], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: dBController,
                      text: testParameters[2], hinttext: parameterDefinitions[2], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: aPController,
                      text: testParameters[3], hinttext: parameterDefinitions[3], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: alamineController,
                      text: testParameters[4], hinttext: parameterDefinitions[4], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: aspartateController,
                      text: testParameters[5], hinttext: parameterDefinitions[5], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: totalProteinsController,
                      text: testParameters[6], hinttext: parameterDefinitions[6], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: albuminController,
                      text: testParameters[7], hinttext: parameterDefinitions[7], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: albuminAndGlobulinController,
                      text: testParameters[8], hinttext: parameterDefinitions[8], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: genderController,
                      text: testParameters[9], hinttext: parameterDefinitions[9], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),


              /////////////////

              SizedBox(height: 30,),

              Center(
                child: TextButton(onPressed: handleLiverDiseaseModel, child: Text("Get Results",style: GoogleFonts.lato(
                    fontSize: 20,
                    color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20,vertical: 10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))

                  ),
                ),
              ),

              SizedBox(height: 30,),


            ],
          ),
        ),
      ),
    );
  }

  void handleLiverDiseaseModel() async{



    setState((){
      isLoading=true;
    });


    Map<String,dynamic> queryParametsrs={
      'Age': ageController.text,
      'Total_Bilirubin':tBController.text,
      'Direct_Bilirubin':dBController.text,
      'Alkaline_Phosphotase':aPController.text,
      'Alamine_Aminotransferase':alamineController.text,
      'Aspartate_Aminotransferase':aspartateController.text,
      'Total_Protiens':totalProteinsController.text,
      'Albumin':albuminController.text,
      'Albumin_and_Globulin_Ratio':albuminAndGlobulinController.text,
      'Gender': genderController.text,
    };



    print("queryParametsrs: ${queryParametsrs}");

    String? result = await HomeMedicaApi().getLiverDiseaseResults(queryParametsrs);
    if(result == null){
      print("null");
      setState((){
        isLoading=false;
      });
      Get.defaultDialog(
        title: "Result",
        backgroundColor: Colors.transparent,
        titlePadding: EdgeInsets.symmetric(
            horizontal: 10, vertical: 10),
        titleStyle: GoogleFonts.lato(fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.pinkAccent),
        barrierDismissible: false,
        content: ServiceDialog(isPositive: false, contentString: '', isNull: true),
      );
    }else{
      print('Result: ${result}');
      if(result.startsWith("sadly")){

        Get.defaultDialog(
            title: "Result",
            backgroundColor: Colors.transparent,
            titlePadding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 10),
            titleStyle: GoogleFonts.lato(fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.pinkAccent),
            barrierDismissible: false,
            content: ServiceDialog(isPositive: true, contentString: result, isNull: false)
        );
        setState((){
          isLoading=false;
        });

      }else{
        Get.defaultDialog(
            title: "Result",
            backgroundColor: Colors.transparent,
            titlePadding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 10),
            titleStyle: GoogleFonts.lato(fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.pinkAccent),
            barrierDismissible: false,
            content:  ServiceDialog(isPositive: false, contentString: result, isNull: false)

        );
        setState((){
          isLoading=false;
        });
      }


    }

  }
}
