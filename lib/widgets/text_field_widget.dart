import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String text;
  final String hinttext;
  final ThemeController themeController;
  final bool isInteger;
  const MyTextField({Key? key,required this.textEditingController,required this.text,required this.hinttext,
    required this.themeController,
  required this.isInteger
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.text,
      style: GoogleFonts.lato(
        fontSize: 14,
        color: Colors.blue[300],
        fontWeight: FontWeight.w500,
      ),
      validator: (value){

        if(value == null){
          return "Null Value";
        }

        if(value.isEmpty ){
          return "Empty Cell.";
        }
        if(isInteger){
          if(int.tryParse(value) ==null){
            return 'sorry, only an integer number is accepted here.';
          }
        }else{
          if(double.tryParse(value) ==null){
            return 'sorry, only numbers are accepted.';
          }
        }


      },
      decoration: InputDecoration(
        label: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: themeController.isDarkModeEnabled.value
                ? Colors.grey[100]
                : Colors.grey[900],
            fontWeight: FontWeight.w500,
          ),
        ),
        hintText: hinttext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
    );
  }
}

