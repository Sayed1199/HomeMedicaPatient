import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/services/home_medica_api.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:homemedica_patient/widgets/service_dialog.dart';
import 'package:homemedica_patient/widgets/text_field_widget.dart';

class HeartDiseaseModalBottomSheet extends StatefulWidget {
  const HeartDiseaseModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<HeartDiseaseModalBottomSheet> createState() => _HeartDiseaseModalBottomSheetState();
}

class _HeartDiseaseModalBottomSheetState extends State<HeartDiseaseModalBottomSheet> {


  TextEditingController ageController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController chestpainTypeController = TextEditingController();
  TextEditingController restingBloodPressureController = TextEditingController();
  TextEditingController serumColestoralController = TextEditingController();
  TextEditingController fastingBloodSugarController = TextEditingController();
  TextEditingController restingElectrocardiographicResultsController = TextEditingController();
  TextEditingController maxHeartRateController = TextEditingController();
  TextEditingController exerciseInducedAnginaController = TextEditingController();
  TextEditingController stDepressionInducedController = TextEditingController();
  TextEditingController slopeOfThePeakController = TextEditingController();
  TextEditingController numOfMajorVesselsController = TextEditingController();
  TextEditingController targetController = TextEditingController();




  ThemeController themeController = Get.put(ThemeController());

  bool isLoading = false;

  List<String> testParameters=[
    "Age",
    "Sex",
    "CP",
    "RestingBP",
    "Serum Cholestoral",
    "FastingBS",
    "RestingECG",
    "MaxHR",
    "ExerciseAngina",
    "OldPeak",
    "ST_Slope",
    "Number of Major Vessels colored by flourosopy",
    "target",
  ];


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ageController.dispose();
    sexController.dispose();
    chestpainTypeController.dispose();
    restingBloodPressureController.dispose();
    serumColestoralController.dispose();
    fastingBloodSugarController.dispose();
    restingElectrocardiographicResultsController.dispose();
    maxHeartRateController.dispose();
    exerciseInducedAnginaController.dispose();
    slopeOfThePeakController.dispose();
    numOfMajorVesselsController.dispose();
    targetController.dispose();
    stDepressionInducedController.dispose();
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
                      text: testParameters[0], hinttext: "(Integer)",
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
                    child: MyTextField(textEditingController: sexController,
                      text: testParameters[1], hinttext: "0 female, 1 male (Integer)", themeController: themeController,
                      isInteger: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: MyTextField(textEditingController: chestpainTypeController,
                        isInteger: true,
                        text: testParameters[2], hinttext: "0 TA, 1 ATA, 2 NAP, 3 ASY (Integer)", themeController: themeController),
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
                    child: MyTextField(textEditingController: restingBloodPressureController,
                      text: testParameters[3], hinttext: "[mm Hg] (Integer)", themeController: themeController,
                      isInteger: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: serumColestoralController,
                      text: testParameters[4], hinttext: "[mm/dl] (Integer)",
                      themeController: themeController,isInteger: true,),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: MyTextField(textEditingController: fastingBloodSugarController,
                      text: testParameters[5], hinttext: "1 fastingBS > 120 mg/dl, 0 otherwise (Integer)", themeController: themeController,
                      isInteger: true,
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
                    child: MyTextField(textEditingController: restingElectrocardiographicResultsController,
                        isInteger: true,
                        text: testParameters[6], hinttext: "0 normal, 1 ST (Integer)", themeController: themeController),
                  ),
                  SizedBox(width: 10,),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: maxHeartRateController,
                      text: testParameters[7], hinttext: "between 60 and 202 (Integer)", themeController: themeController,
                      isInteger: true,
                    ),
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
                    child: MyTextField(textEditingController: exerciseInducedAnginaController,
                      text: testParameters[8], hinttext: "0: no, 1: integer (Integer)",
                      themeController: themeController,isInteger: true,),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: stDepressionInducedController,
                      text: testParameters[9], hinttext: "(Integer)", themeController: themeController,
                      isInteger: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: MyTextField(textEditingController: slopeOfThePeakController,
                        isInteger: true,
                        text: testParameters[10], hinttext: "0: upSloping, 1: flat, 2: downSloping (Integer)", themeController: themeController),
                  ),
                  SizedBox(width: 10,),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: numOfMajorVesselsController,
                      text: testParameters[11], hinttext: "Area SE (0-3) (Integer)", themeController: themeController,
                      isInteger: true,
                    ),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: MyTextField(textEditingController: targetController,
                      text: testParameters[12], hinttext: "(0-2) (Integer)",
                      themeController: themeController,isInteger: false,),
                  ),
                ],
              ),

              /////////////////

              SizedBox(height: 30,),

              Center(
                child: TextButton(onPressed: handleHeartDiseaseModel, child: Text("Get Results",style: GoogleFonts.lato(
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

  void handleHeartDiseaseModel() async{



    setState((){
      isLoading=true;
    });


    Map<String,dynamic> queryParametsrs={
      'age': ageController.text,
      'sex':sexController.text,
      'chest_pain_type':chestpainTypeController.text,
      'resting_blood_pressure':restingBloodPressureController.text,
      'serum_cholestoral':serumColestoralController.text,
      'fasting_blood_sugar':fastingBloodSugarController.text,
      'resting_electrocardiographic_results':restingElectrocardiographicResultsController.text,
      'maximum_heart_rate_achieved':maxHeartRateController.text,
      'exercise_induced_angina':exerciseInducedAnginaController.text,
      'ST_depression_induced_by_exercise_relative_to_rest': stDepressionInducedController.text,
      'the_slope_of_the_peak_exercise_ST_segment':slopeOfThePeakController.text,
      'number_of_major_vessels_colored_by_flourosopy':numOfMajorVesselsController.text,
      'target':targetController.text
    };



    print("queryParametsrs: ${queryParametsrs}");

    String? result = await HomeMedicaApi().getHeartDiseaseResults(queryParametsrs);
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
