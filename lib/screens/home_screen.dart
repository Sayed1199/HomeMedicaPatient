import 'package:animated_widgets/animated_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/screens/clinics_schedule_screen.dart';
import 'package:homemedica_patient/screens/history_screen.dart';
import 'package:homemedica_patient/screens/hospital_chat.dart';
import 'package:homemedica_patient/screens/profile_page_screen/user_profile.dart';
import 'package:homemedica_patient/screens/test_screen.dart';
import 'package:homemedica_patient/screens/video_meeting_screen.dart';
import 'package:homemedica_patient/widgets/booked_home_widget.dart';
import 'package:homemedica_patient/widgets/drawer_widget.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:homemedica_patient/widgets/main_home_widget.dart';
import 'package:homemedica_patient/widgets/table_home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeController themeController = Get.put(ThemeController());



  List<GButton> gButtons= [
    GButton(
      icon: CupertinoIcons.home,
      text: 'Home',
    ),
    GButton(
      icon: CupertinoIcons.calendar,
      text: 'Clinics',
    ),

    GButton(
      icon: FontAwesomeIcons.history,
      text: 'History',
    ),

    GButton(
      icon: Icons.person,
      text: 'Profile',
    ),
  ];

  final PageController ctrl = PageController(
    viewportFraction: 0.85,
  );

  int _selectedIndex = 0;
  int currentPage = 0;


  @override
  void initState() {
    super.initState();

    ctrl.addListener(() {
      int pos = ctrl.page!.round();
      if (currentPage != pos) {
        {
          setState(() {
            currentPage = pos;
          });
        }
      }
    });

  }



@override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Obx(
          () => Text.rich(TextSpan(children: [
            TextSpan(
                text: 'Home',
                style: GoogleFonts.lato(
                    fontSize: 24,
                    color: themeController.isDarkModeEnabled.value
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w400)),
            TextSpan(
                text: 'Medica',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.pink,
                    fontWeight: FontWeight.w500)),
          ])),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Obx(
              () => Image.asset('assets/images/menu0.png',
                  width: 30,
                  height: 30,
                  color: themeController.isDarkModeEnabled.value
                      ? Colors.white
                      : Colors.black),
            ),
          );
        }),

        actions: [

          authController.firebaseUser.value != null?  StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(authController.firebaseUser.value!.uid)
              .collection("rooms").snapshots(),
              builder: (context,snapshots){

              if(snapshots.hasData){
                if(snapshots.data!.docs.isNotEmpty) {
                  return ShakeAnimatedWidget(
                    enabled: true,
                    duration: Duration(milliseconds: 1500),
                    shakeAngle: Rotation.deg(z: 40),
                    curve: Curves.linear,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () async{
                          Get.to(()=>VideoMeetingScreen());
                        },
                        child: GlowIcon(
                          CupertinoIcons.bell,
                          color: Colors.blue,
                          glowColor: Colors.pinkAccent,
                          size: 30,
                          blurRadius: 9,
                        ),
                      ),

                    ),
                  );
                }else{
                  return Container(width: 0,height: 0,);
                }
              }else{
                return Container(width: 0,height: 0,);
              }

              }
          ):Container(width: 0,height:0),




        ],

      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Obx(()=>
              GNav(
                rippleColor: Colors.pinkAccent,
                hoverColor: Colors.pink,
                gap: 8,
                activeColor: Colors.blue,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: themeController.isDarkModeEnabled.value?Colors.grey[100]!:Colors.grey[900]!,
                color: Colors.grey[600],
                tabs: gButtons,
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {

                    _selectedIndex = index;
                    print('selected index: ${_selectedIndex}');

                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child:  Padding(
          padding: EdgeInsets.only(left: 0,top: 8,bottom: 0,right: 0),
          child: _selectedIndex==0? PageView(
            controller: ctrl,
            children: <Widget>[

              MainHomeScreenWidget(),
              HospitalTableHomeWidget(),
              BookedHomeWidget(),

            ],
          )
          :_selectedIndex==1?
          ClinicsScheduleScreen()
          //TestScreen()
          :_selectedIndex==2?  HistoryScreen()
              :ProfilePage()
        ),

      ),
    );
  }
}


