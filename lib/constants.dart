import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/screens/HomeMedicaServices.dart';

String anonPic = "https://firebasestorage.googleapis.com/v0/b/homemedica-eaa1f.appspot.com/o/anonUser.jpg?alt=media&token=47f395f4-2786-4301-bf03-e4184eebeea7";

final String USERS_COLLECTION="USERS";
final String SOS_COLLECTION = 'SOS';
final String BOOKINGS_COLLECTION='BOOKINGS';
final String HOSPITAL_TABLE_COLLECTION='HOSPITALTABLE';
final String HOSPITAL_RESERVATIONS_COLLECTION='RESERVATIONS';
final String HOSPITAL_CHATS_COLLECTION='HOSPITALCHATS';
final String PATIENT_DIAGNOSIS_HISTORY = "DIAGNOSISHISTORY";


List<String> welcomingSentences=[
  "Hello, i'm your medical assistant miya, i'm here to help",
  "Hello this is miya, your medical assistant, i'm here to help",
];
String welcomingSentence2="i'm gonna ask you few questions if you may so i could give a better help with the diagnosis";
List<String> askingAboutAge=["could you please tell me how old are you?","May i ask how old are you please",];

String wrongAgeAnswer="sorry sir, The age must be an integer positive number";
String genderSentence = "now tell me your gender please...";
String wrongGenderAnswer="sorry sir, this is not a valid gender";
String symptomsSentence = "please tell me what you are suffering from now";
String waitSentence="now please wait while i analyze your symptoms";
String askForBooking="Execuse me, sir would you like me to book a meeting for u with one of our doctors?";

int MIN_AGE = 12;
int MAX_AGE = 130;


Map<String,String> SexNorm = {
  "male": "male",
  "m": "male",
  "man": "male",
  "boy": "male",
  "female": "female",
  "f": "female",
  "woman": "female",
  "girl": "female",
  "hombre": "male",
  "mujer": "female",
  "varón": "male",
  "varon": "male",
  "señor": "male",
  "senhor": "male",
  "senor": "male",
  "señora": "female",
  "senora": "female",
  "senhora": "female",
};

Map<String,String> AnswerNorm = {
  "yes": "present",
  "y": "present",
  "yup": "present",
  "yeah":"present",
  "whatever":"present",
  "definitely": "present",
  "sure": "present",
  "surely": "present",
  "present": "present",
  "okay":"present",
  "K":"present",
  "k":"present",
  "no": "absent",
  "n": "absent",
  "nah": "absent",
  "nope": "absent",
  "absent": "absent",
  "?": "unknown",
  "skip": "unknown",
  "unknown": "unknown",
  "dont know": "unknown",
  "don't know": "unknown",
  "sí": "present",
  "si": "present",
  "no lo sé": "unknown",
  "no lo se": "unknown",
  "omitir": "unknown",
  "omita": "unknown",
  "salta": "unknown",
};


enum SexType{
  Male,
  Female,
  Other
}

class PalletteColors{
  static get primaryRed => Color(0xffFD5D5D);
  static get lightSkin => Color(0xffF4DED6);
  static get lightBlue => Color(0xffC8D5EB);
  static get primaryGrey => Color(0xff3A4255);
  static get g1 => Color(0xffFD5D5D);
  static get g2 => Color(0xffFCCF31);
}

TextStyle servicesHeaderStyle = GoogleFonts.abrilFatface(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
);
TextStyle serviceHeaderDefinitionStyle = GoogleFonts.abhayaLibre(
    fontSize: 18,
    color: themeController.isDarkModeEnabled.value?Colors.grey[400]:Colors.grey[600]
);

TextStyle parametersHeaderStyle = GoogleFonts.abhayaLibre(
    fontSize: 18,
    color: themeController.isDarkModeEnabled.value?Colors.grey[400]:Colors.grey[600]
);

TextStyle parameterDefinitionStyle = GoogleFonts.akayaTelivigala(
    fontSize: 16,
    color: themeController.isDarkModeEnabled.value?Colors.grey[400]:Colors.grey[600]
);



List<String> emergencies=["Choking","Fainting","Convulsions","Heatstroke","Hypothermia","Allergic Reactions","Fractures","Unconsciousness","Electric shock & Drowning",
"Poisons","Cuts and Scrapes","Sprains and Strains","Nosebleeds","Splinters","Animal Bites and Insect Stings",
"Minor Burns","Poison Ivy and Other Poisonous Plants"];


List<String> specialities = [
  "Cardiology",
  "Dentistry",
  "Pediatrics",
  "Ophthalmology",
  "Orthopaedics"
];

String agoraAppID = "c1b14a05815a4c87b2adcf28bb7e792f";
String agoraTempToken="006c1b14a05815a4c87b2adcf28bb7e792fIAAkfmXomO1CwyMRbWLYhkSoh3b51R43HiHZSF/HLCoTG3GsM1UAAAAAEAAtDEjT9WjdYgEAAQD3aN1i";
String agoraChannelName="homeMedica";





