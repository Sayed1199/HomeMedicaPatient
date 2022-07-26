import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/services/home_medica_api.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:homemedica_patient/widgets/service_dialog.dart';
import 'package:homemedica_patient/widgets/text_field_widget.dart';

class DiabetesModalBottomSheet extends StatefulWidget {
  const DiabetesModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<DiabetesModalBottomSheet> createState() =>
      _DiabetesModalBottomSheetState();
}

class _DiabetesModalBottomSheetState extends State<DiabetesModalBottomSheet> {
  TextEditingController pregnancyController = TextEditingController();
  TextEditingController glucoseController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();
  TextEditingController skinThicknessController = TextEditingController();
  TextEditingController insulinLevelController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController pedigreeController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  ThemeController themeController = Get.put(ThemeController());
  
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pregnancyController.dispose();
    glucoseController.dispose();
    bloodPressureController.dispose();
    skinThicknessController.dispose();
    insulinLevelController.dispose();
    bmiController.dispose();
    pedigreeController.dispose();
    ageController.dispose();
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
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: pregnancyController,
                        text: "Number Of Pregnancies", hinttext: "Pregnancy number (integer)",
                        themeController: themeController,isInteger: true,),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: bloodPressureController,
                        text: "BP", hinttext: "Blood Pressure (number)", themeController: themeController,
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
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: glucoseController,
                        isInteger: false,
                        text: "Glucose", hinttext: "Glucose Concent (number)", themeController: themeController),
                  ),
                  SizedBox(width: 10,),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: skinThicknessController,
                        isInteger: false,
                        text: "Skin Thickness", hinttext: "Skin Thickness (number)", themeController: themeController),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: insulinLevelController,
                        isInteger: false,
                        text: "Insulin Level", hinttext: "Insulin Level (number)", themeController: themeController),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: bmiController,
                        isInteger: false,
                        text: "BMI", hinttext: "Body mass Index (number)", themeController: themeController),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: pedigreeController,
                        isInteger: false,
                        text: "Pedigree", hinttext: "pedigree function (number)", themeController: themeController),
                  ),
                  SizedBox(width: 10,),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: ageController,
                        isInteger: true,
                        text: "Age", hinttext: "Age - years (integer)", themeController: themeController),
                  ),
                ],
              ),

              SizedBox(height: 30,),

              Center(
                child: TextButton(onPressed: handleDiabetesModel, child: Text("Get Results",style: GoogleFonts.lato(
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

  void handleDiabetesModel() async{

    setState((){
      isLoading=true;
    });

    Map<String,dynamic> queryParametsrs={
      'Number_of_Pregnancies': pregnancyController.text,
      'Glucose':glucoseController.text,
      'Blood_Pressure':bloodPressureController.text,
      'Skin_Thickness':skinThicknessController.text,
      'Insulin_Level':insulinLevelController.text,
      'Body_Mass_Index':bmiController.text,
      'Diabetes_Pedigree_Function':pedigreeController.text,
      'Age':ageController.text
    };

    print("queryParametsrs: ${queryParametsrs}");

    String? result = await HomeMedicaApi().getDiabetesResult(queryParametsrs);
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
