import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ThemeController themeController = Get.put(ThemeController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            floating: true,
            pinned: false,
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Diagnosis History",
              style: GoogleFonts.aBeeZee(
                  color: themeController.isDarkModeEnabled.value
                      ? Colors.grey[100]
                      : Colors.grey[900],
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ];
      },
      body: Center(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection(USERS_COLLECTION)
                .doc(authController.firebaseUser.value!.uid).collection("Prescriptions").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: LoadingWidget(),
                );
              } else {

                List<QueryDocumentSnapshot<Map<String,dynamic>>> data = snapshot.data!.docs;

                if(data.isNotEmpty){
                  print("not empty: ${data[0].data()}");

                  List<Widget> myList = snapshot.data!.docs.map<Widget>((value) {
                    var e = value.data();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      child: Card(
                        color: Colors.black26,
                        shadowColor: Colors.blue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Column(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Date",style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),),
                                  SizedBox(width: 20,),
                                  Obx(()=>
                                      Text('${DateFormat("yyyy-MM-dd    kk:mm").format((Timestamp(int.parse(e['date'].substring(18, 28)),
                                          int.parse(e['date'].substring(42, e['date'].lastIndexOf(')'))))).toDate())}',textAlign: TextAlign.center,style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                                      ),),
                                  )
                                ],
                              ),

                              SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Patient Name",style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),),
                                  SizedBox(width: 20,),
                                  Obx(()=>
                                      Text(e['patientName'],textAlign: TextAlign.center,style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                                      ),),
                                  )
                                ],
                              ),

                              SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Patient Age",style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),),
                                  SizedBox(width: 20,),
                                  Obx(()=>
                                      Text(e['age'],textAlign: TextAlign.center,style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                                      ),),
                                  )
                                ],
                              ),

                              SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Patient Sex",style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),),
                                  SizedBox(width: 20,),
                                  Obx(()=>
                                      Text(e['sex'],textAlign: TextAlign.center,style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                                      ),),
                                  )
                                ],
                              ),

                              SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Patient Diagnosis",style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),),
                                  SizedBox(width: 20,),

                                  Text(e['diagnosis'],textAlign: TextAlign.center,style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),),

                                ],
                              ),

                              SizedBox(height: 30,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Drugs",style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),),
                                  SizedBox(width: 20,),
                                  Obx(() {
                                    String s ="";
                                    (e['drugs'] as List<dynamic>).forEach((element) {
                                      s+="Drug name: ${element['medicineName']},  Dose: ${element['dose']}\n ROA: ${element['notes']}\n";
                                    });
                                    return Text('${s}'.toString(),maxLines: 10 ,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: themeController.isDarkModeEnabled
                                            .value ? Colors.grey[100] : Colors
                                            .grey[900],
                                      ),);}
                                  )
                                ],
                              ),

                              SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Doctor Name",style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),),
                                  SizedBox(width: 20,),
                                  Obx(()=>
                                      Text(e['doctorName'],textAlign: TextAlign.center,style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                                      ),),
                                  )
                                ],
                              ),

                              SizedBox(height: 10,),


                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList();

                  print("List: ${myList}");
                  return
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
                          children: myList
                      ),
                    );


                }else{
                  print("empty");
                  return Center(
                    child: Obx(()=>
                        Text("No Diagnosis History yet.",style: GoogleFonts.lato(
                            fontSize: 22,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                        ),),
                    ),
                  );
                }

              }
            }),

      ),
    ));
  }
}
