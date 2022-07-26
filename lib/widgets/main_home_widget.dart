import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/models/card_model.dart';
import 'package:homemedica_patient/screens/appointment_booking_screen.dart';
import 'package:homemedica_patient/screens/emergency_tips_screen.dart';
import 'package:homemedica_patient/screens/news_screen.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:geolocator/geolocator.dart';


class MainHomeScreenWidget extends StatefulWidget {
  const MainHomeScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainHomeScreenWidget> createState() => _MainHomeScreenWidgetState();
}

class _MainHomeScreenWidgetState extends State<MainHomeScreenWidget> {
  AuthController authController = Get.put(AuthController());
  ThemeController themeController = Get.put(ThemeController());
  String? message;
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);
    setState(() {
      if (hour >= 5 && hour < 12) {
        message = 'Good Morning';
      } else if (hour >= 12 && hour <= 17) {
        message = 'Good Afternoon';
      } else {
        message = 'Good Evening';
      }
    });

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(right: 0),
      child: !loading? ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [

          message==null?Container():
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0,20,20,10),
            child: Text('$message, ${authController.firebaseUser.value==null?'': authController.firebaseUser.value!.displayName}',style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),),
          ),

          SizedBox(height: 20,),

          Center(child: NewsWidget(),),

          SizedBox(height: 20,),


          GestureDetector(
            onTap: (){
              Get.to(()=>EmergencyTipsScreen());
            },
            child: Center(
              child: Container(
                //width: MediaQuery.of(context).size.width*0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.blueAccent
                ),

                child: Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 12),
                child: Text('Emergency Tips',textAlign: TextAlign.center,style: GoogleFonts.actor(
                  fontSize: 22,
                  color: Colors.grey[100]
                ),),
                ),

              ),
            ),
          ),

          SizedBox(height: 30,),

          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Book an Appointment",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Container(
            height: 150,
            padding: EdgeInsets.only(top: 15),
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                //print("images path: ${cards[index].cardImage.toString()}");
                return Container(
                  margin: EdgeInsets.only(right: 14),
                  height: 150,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(cards[index].cardBackground),
                      boxShadow: [
                        BoxShadow(
                          color: themeController.isDarkModeEnabled.value?Colors.grey[600]!: Colors.grey[400]!,
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          offset: Offset(3, 3),
                        ),
                      ]
                  ),

                  child: FlatButton(
                    onPressed: () {

                      Get.to(()=>AppointmentBookingScreen(speciality: cards[index].spciality,index: index,),curve: Curves.easeInCirc,
                      transition: Transition.leftToRightWithFade);


                      print(cards[index].spciality);
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 29,
                              child: Icon(
                                cards[index].cardIcon,
                                size: 26,
                                color:
                                Color(cards[index].cardBackground),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            cards[index].spciality,
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 30,),

          Center(
            child:   Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent,
                      spreadRadius: 4,
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.pinkAccent,
                      spreadRadius: -4,
                      blurRadius: 5,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed:()async{

                    setState((){
                      loading=true;
                    });

                    LocationPermission permission = await Geolocator.checkPermission();

                    if (permission == LocationPermission.denied) {
                      permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.denied) {
                        print('Location permissions are denied');
                        return;
                      }else if(permission == LocationPermission.deniedForever){
                        print("'Location permissions are permanently denied");
                        return;
                      }else{
                        print("GPS Location service is granted");
                      }
                    }else{
                      print("GPS Location permission granted.");
                    }

                    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

                    String long = position.longitude.toString();
                    String lat = position.latitude.toString();

                    Map<String,dynamic> map= {
                      "imageUrl":authController.firebaseUser.value!.photoURL,
                      "responded":false,
                      "latitude":lat,
                      "longitude":long,
                      "timeStamp":Timestamp.now(),
                      "userID":authController.firebaseUser.value!.uid,
                      "username":authController.firebaseUser.value!.displayName
                    };

                    print("map: ${map}");

                    await FirebaseFirestore.instance.collection(SOS_COLLECTION).doc()
                        .set(map,SetOptions(merge:true)).then((value) {
                      Fluttertoast.showToast(msg: "SOS Sent to the hosp",gravity: ToastGravity.BOTTOM,backgroundColor: Colors.blue);
                      setState((){
                        loading=false;
                      });

                    });
                  },
                  child: Text("Send a SOS",style: TextStyle(fontSize: 18),),
                ),
              ),
            ),
          ),

        ],
      ):Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadingWidget(),
          SizedBox(height: 20,),
          Text("Please Wait",style: GoogleFonts.lato(
            fontSize: 22,
            color: Colors.blue
          ),)
        ],
      ),
    );
  }
}


class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 140,
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 20),
      padding: EdgeInsets.only(left: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          stops: [0.3, 0.7],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xffa1d4ed),
            Color(0xffc0eaff),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
               Get.to(()=>NewsScreen());
        },
        child: Stack(
          children: [
            Image.asset(
              "assets/images/414-bg.png",
              fit: BoxFit.fitHeight,
            ),
            Container(
              padding: EdgeInsets.only(top: 7, right: 5),
              alignment: Alignment.topRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Medical News",
                    style: GoogleFonts.lato(
                      color: Colors.lightBlue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.lightBlue[900],
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




