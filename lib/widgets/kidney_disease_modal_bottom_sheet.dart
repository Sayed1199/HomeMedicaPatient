import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/services/home_medica_api.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:homemedica_patient/widgets/service_dialog.dart';
import 'package:homemedica_patient/widgets/text_field_widget.dart';

class KidneyDiseaseModalBottomSheet extends StatefulWidget {
  const KidneyDiseaseModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<KidneyDiseaseModalBottomSheet> createState() => _KidneyDiseaseModalBottomSheetState();
}

class _KidneyDiseaseModalBottomSheetState extends State<KidneyDiseaseModalBottomSheet> {

  TextEditingController ageController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController alController = TextEditingController();
  TextEditingController suController = TextEditingController();
  TextEditingController rbcController = TextEditingController();
  TextEditingController pcController = TextEditingController();
  TextEditingController pccController = TextEditingController();
  TextEditingController baController = TextEditingController();
  TextEditingController bgrController = TextEditingController();
  TextEditingController buController = TextEditingController();
  TextEditingController scController = TextEditingController();
  TextEditingController potController = TextEditingController();
  TextEditingController wcController = TextEditingController();
  TextEditingController htnController = TextEditingController();
  TextEditingController dmController = TextEditingController();
  TextEditingController cadController = TextEditingController();
  TextEditingController peController = TextEditingController();
  TextEditingController aneController = TextEditingController();




  ThemeController themeController = Get.put(ThemeController());

  bool isLoading = false;

  List<String> testParameters=[
    "Age",
    "BP",
    "AL",
    "SU",
    "RBC",
    "PC",
    "PCC",
    "BA",
    "BGR",
    "BU",
    "SC",
    "POT",
    "WC",
    "HTN",
    "DM",
    "CAD",
    "PE",
    "ANE"
  ];

  List<String> parameterDefinitions=[
    "(integer)",
    "Blood Pressure (number)",
    "Albumin (number)",
    "Sugar (integer)",
    "Red Blood Cells (integer)",
    "Pus Cell (integer)",
    "Pus cell Clumps (integer)",
    "Bacteria (integer)",
    "Blood Glucose Random (number)",
    "Blood Urea (number)",
    "Serum Creatinine (number)",
    "Potassium (number)",
    "White Blood Cell Count (number)",
    "Hypertension (integer)",
    "Diabetes Mellitus (integer)",
    "Coronary Artery Disease (integer)",
    "Pedal Edema (integer)",
    "Anemia (integer)"
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    ageController.dispose();
    bpController.dispose();
    suController.dispose();
    alController.dispose();
    rbcController.dispose();
    pccController.dispose();
    pccController.dispose();
    baController.dispose();
    bgrController.dispose();
    buController.dispose();
    scController.dispose();
    potController.dispose();
    wcController.dispose();
    htnController.dispose();
    dmController.dispose();
    cadController.dispose();
    peController.dispose();
    aneController.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return  Container(
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
                    child: MyTextField(textEditingController: bpController,
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
                    child: MyTextField(textEditingController: alController,
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
                    child: MyTextField(textEditingController: suController,
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
                    child: MyTextField(textEditingController: rbcController,
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
                    child: MyTextField(textEditingController: pcController,
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
                    child: MyTextField(textEditingController: pccController,
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
                    child: MyTextField(textEditingController: baController,
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
                    width: MediaQuery.of(context).size.width*0.7,
                    child: MyTextField(textEditingController: bgrController,
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
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: buController,
                      text: testParameters[9], hinttext: parameterDefinitions[9], themeController: themeController,
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
                    child: MyTextField(textEditingController: scController,
                      text: testParameters[10], hinttext: parameterDefinitions[10], themeController: themeController,
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
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: potController,
                      text: testParameters[11], hinttext: parameterDefinitions[11], themeController: themeController,
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
                    width: MediaQuery.of(context).size.width*0.7,
                    child: MyTextField(textEditingController: wcController,
                      text: testParameters[12], hinttext: parameterDefinitions[12], themeController: themeController,
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
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: htnController,
                      text: testParameters[13], hinttext: parameterDefinitions[13], themeController: themeController,
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
                    child: MyTextField(textEditingController: dmController,
                      text: testParameters[14], hinttext: parameterDefinitions[14], themeController: themeController,
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
                    width: MediaQuery.of(context).size.width*0.7,
                    child: MyTextField(textEditingController: cadController,
                      text: testParameters[15], hinttext: parameterDefinitions[15], themeController: themeController,
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
                    child: MyTextField(textEditingController: peController,
                      text: testParameters[16], hinttext: parameterDefinitions[16], themeController: themeController,
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
                    width: MediaQuery.of(context).size.width*0.5,
                    child: MyTextField(textEditingController: aneController,
                      text: testParameters[17], hinttext: parameterDefinitions[17], themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),




              /////////////////

              SizedBox(height: 30,),

              Center(
                child: TextButton(onPressed: handleKidneyDiseaseModel, child: Text("Get Results",style: GoogleFonts.lato(
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

  void handleKidneyDiseaseModel() async{



    setState((){
      isLoading=true;
    });


    Map<String,dynamic> queryParametsrs={
      'age': ageController.text,
      'bp':bpController.text,
      'al':alController.text,
      'su':suController.text,
      'rbc':rbcController.text,
      'pc':pccController.text,
      'pcc':pccController.text,
      'ba':baController.text,
      'bgr':bgrController.text,
      'bu': buController.text,
      'sc':scController.text,
      'pot':potController.text,
      'wc':wcController.text,
      'htn':htnController.text,
      'dm':dmController.text,
      'cad':cadController.text,
      'pe':peController.text,
      'ane': aneController.text,
    };



    print("queryParametsrs: ${queryParametsrs}");

    String? result = await HomeMedicaApi().getKidneyDiseaseResults(queryParametsrs);
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
