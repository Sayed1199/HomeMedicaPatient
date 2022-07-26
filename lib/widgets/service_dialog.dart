import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';

class ServiceDialog extends StatefulWidget {
  final bool isPositive;
  final bool isNull;
  final String contentString;
  const ServiceDialog({Key? key,required this.isPositive,required this.contentString,required this.isNull}) : super(key: key);

  @override
  State<ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return widget.isNull? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("smth wrong happened, pls try again",
            textAlign: TextAlign.center, style: GoogleFonts.actor(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeController.isDarkModeEnabled.value
                    ? Colors.grey[100]
                    : Colors.grey[900]
            )),

        SizedBox(height: 20,),

        GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(CupertinoIcons.left_chevron),
          ),
        ),

      ],
    ):widget.isPositive?Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/depression.jpg'),
          radius: 50,
        ),


        Center(
          child: Text(widget.contentString,
              textAlign: TextAlign.center, style: GoogleFonts.actor(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDarkModeEnabled.value
                      ? Colors.grey[100]
                      : Colors.grey[900]
              )),
        ),


        SizedBox(height: 30,),

        GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(CupertinoIcons.left_chevron),
          ),
        ),


      ],
    ): Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(widget.contentString,
              textAlign: TextAlign.center, style: GoogleFonts.actor(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDarkModeEnabled.value
                      ? Colors.grey[100]
                      : Colors.grey[900]
              )),
        ),

        SizedBox(height: 30,),

        GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(CupertinoIcons.left_chevron),
          ),
        ),

      ],
    );
  }
}
