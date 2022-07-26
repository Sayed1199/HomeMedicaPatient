import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/services/home_medica_api.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:homemedica_patient/widgets/service_dialog.dart';
import 'package:homemedica_patient/widgets/text_field_widget.dart';
class BreastCancerModalBottomSheet extends StatefulWidget {
  const BreastCancerModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<BreastCancerModalBottomSheet> createState() => _BreastCancerModalBottomSheetState();
}

class _BreastCancerModalBottomSheetState extends State<BreastCancerModalBottomSheet> {

  TextEditingController radiusMeanController = TextEditingController();
  TextEditingController textureMeanController = TextEditingController();
  TextEditingController perimeterMeanController = TextEditingController();
  TextEditingController areaMeanController = TextEditingController();
  TextEditingController smoothnessMeanController = TextEditingController();
  TextEditingController compactnessMeanController = TextEditingController();
  TextEditingController concavityMeanController = TextEditingController();
  TextEditingController concavePointsMeanController = TextEditingController();
  TextEditingController symmetryMeanController = TextEditingController();
  TextEditingController radiusSEController = TextEditingController();
  TextEditingController perimeterSEController = TextEditingController();
  TextEditingController areaSEController = TextEditingController();
  TextEditingController compactnessSEController = TextEditingController();
  TextEditingController concavitySEController = TextEditingController();
  TextEditingController concavePointsSEController = TextEditingController();
  TextEditingController fractalDimensionSEController = TextEditingController();
  TextEditingController radiusWorstController = TextEditingController();
  TextEditingController textureWorstController = TextEditingController();
  TextEditingController perimeterWorstController = TextEditingController();
  TextEditingController areaWorstController = TextEditingController();
  TextEditingController smoothnessWorstController = TextEditingController();
  TextEditingController compactnessWorstController = TextEditingController();
  TextEditingController concavityWorstController = TextEditingController();
  TextEditingController concavePointsWorstController = TextEditingController();
  TextEditingController symmetryWorstController = TextEditingController();
  TextEditingController fractalDimensionWorstController = TextEditingController();



  ThemeController themeController = Get.put(ThemeController());

  bool isLoading = false;

  List<String> testParameters=[
    "Radius Mean",
    "Texture Mean",
    "Perimeter Mean",
    "Area Mean",
    "Smoothness Mean",
    "Compactness Mean",
    "Concavity Mean",
    "Concave Points Mean",
    "Symmetry Mean",
    "Radius SE",
    "Perimeter SE",
    "Area SE",
    "Compactness SE",
    "Concavity SE",
    "Concave Points SE",
    "Fractal Dimension SE",
    "Radius Worst",
    "Texture Worst",
    "Perimeter Worst",
    "Area Worst",
    "Smoothness Worst",
    "Compactness Worst",
    "Concavity Worst",
    "Concave Points Worst",
    "Symmetry Worst",
    "Fractal Dimension Worst",
  ];


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    radiusMeanController.dispose();
    textureMeanController.dispose();
    perimeterMeanController.dispose();
    areaMeanController.dispose();
    smoothnessMeanController.dispose();
    compactnessMeanController.dispose();
    concavePointsMeanController.dispose();
    concavityMeanController.dispose();
    symmetryMeanController.dispose();
    radiusSEController.dispose();
    perimeterSEController.dispose();
    areaSEController.dispose();
    compactnessSEController.dispose();
    concavitySEController.dispose();
    concavePointsSEController.dispose();
    fractalDimensionSEController.dispose();
    radiusWorstController.dispose();
    textureWorstController.dispose();
    perimeterWorstController.dispose();
    areaWorstController.dispose();
    smoothnessWorstController.dispose();
    compactnessWorstController.dispose();
    concavityWorstController.dispose();
    concavePointsWorstController.dispose();
    symmetryWorstController.dispose();
    fractalDimensionWorstController.dispose();

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
                    child: MyTextField(textEditingController: radiusMeanController,
                      text: testParameters[0], hinttext: "Radius mean (number)",
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
                    child: MyTextField(textEditingController: textureMeanController,
                      text: testParameters[1], hinttext: "Texture mean (number)", themeController: themeController,
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
                    child: MyTextField(textEditingController: perimeterMeanController,
                        isInteger: false,
                        text: testParameters[2], hinttext: "Perimeter mean (number)", themeController: themeController),
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
                    child: MyTextField(textEditingController: areaMeanController,
                      text: testParameters[3], hinttext: "Area mean (number)", themeController: themeController,
                      isInteger: false,
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
                    child: MyTextField(textEditingController: smoothnessMeanController,
                      text: testParameters[4], hinttext: "Smoothness mean (number)",
                      themeController: themeController,isInteger: false,),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: compactnessMeanController,
                      text: testParameters[5], hinttext: "Compactness mean (number)", themeController: themeController,
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
                    child: MyTextField(textEditingController: concavityMeanController,
                        isInteger: false,
                        text: testParameters[6], hinttext: "Concavity mean (number)", themeController: themeController),
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
                    child: MyTextField(textEditingController: concavePointsMeanController,
                      text: testParameters[7], hinttext: "Concave Points mean (number)", themeController: themeController,
                      isInteger: false,
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
                    child: MyTextField(textEditingController: symmetryMeanController,
                      text: testParameters[8], hinttext: "Symmetry mean (number)",
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
                    child: MyTextField(textEditingController: radiusSEController,
                      text: testParameters[9], hinttext: "Radius SE (number)", themeController: themeController,
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
                    child: MyTextField(textEditingController: perimeterSEController,
                        isInteger: false,
                        text: testParameters[10], hinttext: "Perimeter SE (number)", themeController: themeController),
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
                    child: MyTextField(textEditingController: areaSEController,
                      text: testParameters[11], hinttext: "Area SE (number)", themeController: themeController,
                      isInteger: false,
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
                    child: MyTextField(textEditingController: compactnessSEController,
                      text: testParameters[12], hinttext: "Compactness SE (number)",
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
                    child: MyTextField(textEditingController: concavitySEController,
                      text: testParameters[13], hinttext: "Concavity SE (number)", themeController: themeController,
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
                    child: MyTextField(textEditingController: concavePointsSEController,
                        isInteger: false,
                        text: testParameters[14], hinttext: "Concave Points SE (number)", themeController: themeController),
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
                    child: MyTextField(textEditingController: fractalDimensionSEController,
                      text: testParameters[15], hinttext: "Fractal Dimension SE (number)", themeController: themeController,
                      isInteger: false,
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
                    child: MyTextField(textEditingController: radiusWorstController,
                      text: testParameters[16], hinttext: "Radius Worst (number)",
                      themeController: themeController,isInteger: false,),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: textureWorstController,
                        isInteger: false,
                        text: testParameters[17], hinttext: "Texture Worst (number)", themeController: themeController),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: perimeterWorstController,
                      text: testParameters[18], hinttext: "Perimeter Worst (number)", themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: areaWorstController,
                      text: testParameters[19], hinttext: "Area Worst (number)",
                      themeController: themeController,isInteger: false,),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: smoothnessWorstController,
                      text: testParameters[20], hinttext: "Smoothness Worst (number)", themeController: themeController,
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
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: compactnessWorstController,
                        isInteger: false,
                        text: testParameters[21], hinttext: "Compactness Worst (number)", themeController: themeController),
                  ),
                  SizedBox(width: 10,),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: concavityWorstController,
                      text: testParameters[22], hinttext: "Concavity Worst (number)", themeController: themeController,
                      isInteger: false,
                    ),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: MyTextField(textEditingController: concavePointsWorstController,
                      text: testParameters[23], hinttext: "Concave Points Worst (number)",
                      themeController: themeController,isInteger: false,),
                  ),
                ],
              ),


              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: MyTextField(textEditingController: symmetryWorstController,
                      text: testParameters[24], hinttext: "Symmetry Worst (number)", themeController: themeController,
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
                    child: MyTextField(textEditingController: fractalDimensionWorstController,
                        isInteger: false,
                        text: testParameters[25], hinttext: "Fractal Dimension Worst (number)", themeController: themeController),
                  ),
                  SizedBox(width: 10,),
                ],
              ),

              /////////////////

              SizedBox(height: 30,),

              Center(
                child: TextButton(onPressed: handleBreastCancerModel, child: Text("Get Results",style: GoogleFonts.lato(
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

  void handleBreastCancerModel() async{


    setState((){
      isLoading=true;
    });

    
    Map<String,dynamic> queryParametsrs={
      'radius_mean': radiusMeanController.text,
      'texture_mean':textureMeanController.text,
      'perimeter_mean':perimeterMeanController.text,
      'area_mean':areaMeanController.text,
      'smoothness_mean':smoothnessMeanController.text,
      'compactness_mean':compactnessMeanController.text,
      'concavity_mean':concavityMeanController.text,
      'concave_points_mean':concavePointsMeanController.text,
      'symmetry_mean':symmetryMeanController.text,
      'radius_se': radiusSEController.text,
      'perimeter_se':perimeterSEController.text,
      'area_se':areaSEController.text,
      'compactness_se':compactnessSEController.text,
      'concavity_se':concavitySEController.text,
      'concave_points_se':concavePointsSEController.text,
      'fractal_dimension_se':fractalDimensionSEController.text,
      'radius_worst':radiusWorstController.text,
      'texture_worst': textureWorstController.text,
      'perimeter_worst':perimeterWorstController.text,
      'area_worst':areaWorstController.text,
      'smoothness_worst':smoothnessWorstController.text,
      'compactness_worst':compactnessWorstController.text,
      'concavity_worst':concavityWorstController.text,
      'concave_points_worst':concavePointsWorstController.text,
      'symmetry_worst':symmetryWorstController.text,
      'fractal_dimension_worst':fractalDimensionWorstController.text,
    };
    


    print("queryParametsrs: ${queryParametsrs}");

    String? result = await HomeMedicaApi().getBreastcancerResults(queryParametsrs);
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
