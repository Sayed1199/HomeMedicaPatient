import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/models/user_model.dart';
import 'package:homemedica_patient/screens/HomeMedicaServices.dart';
import 'package:homemedica_patient/screens/home_screen.dart';
import 'package:homemedica_patient/screens/hospital_chat.dart';
import 'package:homemedica_patient/screens/mia_chat_screen.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeController themeController = Get.put(ThemeController());
    AuthController authController = Get.put(AuthController());

    return Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(35),bottomRight: Radius.circular(70)),
        child: Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                GestureDetector(
                    onTap: (){
                      Get.offAll(()=>HomeScreen());
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.cyan
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){
                            }, icon:Icon(FontAwesomeIcons.home),iconSize: 30,),
                            SizedBox(width: 10,),
                            Text('Home',style: TextStyle(fontSize: 22),),
                          ],
                        ))),

                SizedBox(height: 20,),

                GestureDetector(
                    onTap: (){
                      Get.to(()=>HospitalChatScreen());
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.blueGrey
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){
                            }, icon:Icon(FontAwesomeIcons.hospital),iconSize: 30,),
                            SizedBox(width: 10,),
                            Text('Hospital Chat',style: TextStyle(fontSize: 22),),
                          ],
                        ))),

                SizedBox(height: 20,),


                GestureDetector(
                  onTap: (){

                    Get.to(()=>MiaChatScreen(),transition: Transition.circularReveal,curve: Curves.bounceInOut);

                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(35),
                          //color: Colors.orange,
                        gradient:LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.purple, Colors.orange]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.computer),iconSize: 30,),
                          SizedBox(width: 10,),
                          Text('Chat Wih Miya',style: TextStyle(fontSize: 22),),
                        ],
                      )),
                ),

                SizedBox(height: 20,),

                GestureDetector(
                    onTap: (){
                      Get.to(()=>HomeMedicaServices());
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.teal
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){
                            }, icon:Icon(FontAwesomeIcons.clinicMedical),iconSize: 30,),
                            SizedBox(width: 10,),
                            Text('HomeMedica Services',style: TextStyle(fontSize: 18),),
                          ],
                        ))),

                SizedBox(height: 20,),


                GestureDetector(
                  onTap: (){
                    themeController.isDarkModeEnabled.value = !themeController.isDarkModeEnabled.value;                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.pink
                      ),
                      child:
                      Obx(()=> Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){},
                            icon: themeController.isDarkModeEnabled.value?
                          Icon(FontAwesomeIcons.solidSun,):
                          Icon(FontAwesomeIcons.moon),iconSize: 30,),
                          Text(themeController.modeText,style: TextStyle(fontSize: 22),),
                        ],
                      ))),
                ),


                SizedBox(height: 20,),


                GestureDetector(
                  onTap: (){
                    authController.signOut();
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.pinkAccent
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.doorOpen),iconSize: 30,),
                          SizedBox(width: 5,),
                          Text('Sign Out',style: TextStyle(fontSize: 22),),
                        ],
                      )),
                ),




              ],

            ),
          ),
        ),

      ),
    );
  }
}
