import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homemedica_patient/screens/profile_page_screen/edit_email_screen.dart';
import 'package:homemedica_patient/screens/profile_page_screen/edit_image_screen.dart';
import 'package:homemedica_patient/screens/profile_page_screen/edit_name_screen.dart';
import 'package:homemedica_patient/screens/profile_page_screen/edit_phone_screen.dart';
import 'package:homemedica_patient/screens/profile_page_screen/widgets/prfile_appbar.dart';
import 'package:homemedica_patient/widgets/display_profile_image.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  AuthController authController = Get.put(AuthController());
  UserModel? userModel;

  @override
  void initState(){
    super.initState();
     FirebaseFirestore.instance.collection(USERS_COLLECTION)
        .doc(authController.firebaseUser.value!.uid).get().then((value) {
          userModel = UserModel.getUserModelFromJson(value.data() as Map<String,dynamic>);
          setState((){

          });
     });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: userModel==null?Center(
        child: LoadingWidget(),
      ):
      Column(

        children: [
          Center(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.lato(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                    )
                  ))),
          InkWell(
              onTap: () {
                Get.to(()=>EditImagePage(),
                transition: Transition.leftToRightWithFade,
                curve: Curves.bounceInOut,
                arguments: userModel
                );
              },
              child: DisplayImage(
                imagePath: userModel!.imageUrl!,
                onPressed: () {},
              )),
          SizedBox(height: 10,),
          buildUserInfoDisplay(userModel!.username!, 'Name', EditNameFormPage()),
          SizedBox(height: 10,),
          buildUserInfoDisplay(userModel!.email!, 'Email', EditEmailFormPage()),
          SizedBox(height: 10,),
          buildUserInfoDisplay(userModel!.phoneNumber==null?'':userModel!.phoneNumber!, 'Phone', EditPhoneFormPage()),
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  title,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                  )
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              Get.to(()=>editPage,arguments: userModel,transition: Transition.zoom,curve: Curves.bounceInOut);
                            },
                            child: Text(
                              getValue,
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue
                              ),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }

}