import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/breast_cancer_part.dart';
import 'package:homemedica_patient/widgets/covid19_disease_part.dart';
import 'package:homemedica_patient/widgets/diabetes_part.dart';
import 'package:homemedica_patient/widgets/heartDisease_part.dart';
import 'package:homemedica_patient/widgets/kidney_disease_part.dart';
import 'package:homemedica_patient/widgets/liver_disease_part.dart';
import 'package:homemedica_patient/widgets/malaria_disease_part.dart';
import 'package:homemedica_patient/widgets/pneumonia_disease_part.dart';

ThemeController themeController = Get.put(ThemeController());


class HomeMedicaServices extends StatefulWidget {
  const HomeMedicaServices({Key? key}) : super(key: key);

  @override
  State<HomeMedicaServices> createState() => _HomeMedicaServicesState();
}

class _HomeMedicaServicesState extends State<HomeMedicaServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("HomeMedica Services",style: GoogleFonts.actor(
          fontSize: 20,
          color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
          fontWeight: FontWeight.w500
        ),),
      ),
      body: Center(
        child: CupertinoScrollbar(
          child: ListView(
            children: [

              SizedBox(height: 20,),
              DiabetesPart(),
              SizedBox(height: 30,),
              BreastCancerPart(),
              SizedBox(height: 30,),
              HeartDiseasePart(),
              SizedBox(height: 30,),
              KidneyDiseasePart(),
              SizedBox(height: 30,),
              LiverDiseasePart(),
              SizedBox(height: 30,),
              MalariaDiseasePart(),
              SizedBox(height: 30,),
              PneumoniaDiseasePart(),
              SizedBox(height: 30,),
              Covid19DiseasePart(),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),

    );
  }
}

