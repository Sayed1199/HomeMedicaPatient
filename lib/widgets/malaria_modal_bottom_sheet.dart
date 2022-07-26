import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/services/home_medica_api.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:homemedica_patient/widgets/service_dialog.dart';
import 'package:image_picker/image_picker.dart';

class MalariaModalBottomSheet extends StatefulWidget {
  const MalariaModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<MalariaModalBottomSheet> createState() => _MalariaModalBottomSheetState();
}

class _MalariaModalBottomSheetState extends State<MalariaModalBottomSheet> {

  ThemeController themeController = Get.put(ThemeController());

  bool isLoading = false;

  bool isImagePicked=false;

   XFile? pickedImage;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: isLoading?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingWidget(),
            SizedBox(height: 10,),
            Text("Please Wait...",style: GoogleFonts.lato(
                fontSize: 22,
                color: Colors.blue
            ),),
          ],
        ) :CupertinoScrollbar(
          child: ListView(
            children: [

              SizedBox(height: 30,),


              Center(
                child: !isImagePicked? Center(
                  child: GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue
                      ),
                      child: Text("Upload Cell Image",style: GoogleFonts.lato(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                      ),),
                    ),
                  ),
                ):CircleAvatar(

                  backgroundImage: FileImage(new File(pickedImage!.path)),
                  backgroundColor: Colors.transparent,
                  radius: 50,

                ),
              ),

              /////////////////

              SizedBox(height: 30,),

              isImagePicked? Center(
                child: TextButton(onPressed: handleMalariaModel, child: Text("Get Results",style: GoogleFonts.lato(
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
              ):Container(width: 0,height: 0,),

              SizedBox(height: 30,),


            ],
          ),
        ),
      ),
    );
  }

  void handleMalariaModel() async{

    String? result = await HomeMedicaApi().getMalariaDiseaseResults(pickedImage!);

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

  void pickImage() async {

    ImagePicker imagePicker = ImagePicker();
    pickedImage =await imagePicker.pickImage(source: ImageSource.gallery);

    if(pickedImage != null){
      setState((){
        isImagePicked=true;
      });
    }

  }
}
