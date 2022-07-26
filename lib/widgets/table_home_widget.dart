import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/utils/utils.dart';
import 'package:intl/intl.dart';

class HospitalTableHomeWidget extends StatefulWidget {
  const HospitalTableHomeWidget({Key? key}) : super(key: key);

  @override
  State<HospitalTableHomeWidget> createState() => _HospitalTableHomeWidgetState();
}

class _HospitalTableHomeWidgetState extends State<HospitalTableHomeWidget> {

  ThemeController themeController = Get.put(ThemeController());

  String curDay='';

  TextStyle headerFontStyle = GoogleFonts.lato(
      color: ThemeController().isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
      fontSize: 16,
      fontWeight: FontWeight.w400
  );


  @override
  void initState(){
    super.initState();
    curDay = DateFormat('EEEE').format(DateTime.now());
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(left: 0,right: 0,top: 20),


      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder(
              future: Utils().getHospitalTable(),
              builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }

                Map<String,dynamic> daysMap={};
                List<DocumentSnapshot> docs = snapshot.data!.docs;
                docs.forEach((element) {
                  daysMap[element.id]=element.data() as Map<String,dynamic>;
                });


                List<String> saturdayStrings=['Cell Saturday0','Cell Saturday1','Cell Saturday2','Cell Saturday3','Cell Saturday4'];
                List<String> sundayStrings=['Cell sunday0','Cell sunday1','Cell Sunday2','Cell Sunday3','Cell Sunday4'];
                List<String> mondayStrings=['Cell monday0','Cell monday1','Cell monday2','Cell monday3','Cell monday4'];
                List<String>tuesdayStrings=['Cell tuesday0','Cell tuesday1','Cell tuesday2','Cell tuesday3','Cell tuesday4'];
                List<String>wednesdayStrings=['Cell wednesday0','Cell wednesday1','Cell wednesday2','Cell wednesday3','Cell wednesday4'];
                List<String>thursdayStrings=['Cell thursday0','Cell thursday1','Cell thursday2','Cell thursday3','Cell thursday4'];
                List<String>fridayStrings=['Cell friday0','Cell friday1','Cell friday2','Cell friday3','Cell friday4'];
                List<String> days=['SATURDAY','SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY'];
                List<String>specialities=['Cardiology','Dentistry','Pediatrics','Ophthalmology','Orthopaedics'];



                List<Widget> saturdayList=List<Widget>.generate(saturdayStrings.length, (index) {
                  return Container(
                      color: curDay == days[0] ? Colors.blue : Colors
                          .transparent,
                      margin: EdgeInsets.all(1),
                      child: Center(
                          child: Text(
                            '${daysMap[days[0]][specialities[index]]['name']}\n${daysMap[days[0]][specialities[index]]['time']}',
                          ))
                  );
                }
                        );



                List<Widget>sundayList=List<Widget>.generate(sundayStrings.length, (index) => Container(
                    color: curDay == days[1] ? Colors.blue : Colors
                        .transparent,
                    margin: EdgeInsets.all(1),
                    child: Center(
                        child: Text(
                          '${daysMap[days[1]][specialities[index]]['name']}\n${daysMap[days[1]][specialities[index]]['time']}',
                        ))));


                List<Widget> mondayList=List<Widget>.generate(mondayStrings.length, (index) => Container(
                    color: curDay == days[2]?Colors.blue: Colors.transparent,
                    margin: EdgeInsets.all(1),
                    child: Center(
                        child: Text(
                          '${daysMap[days[2]][specialities[index]]['name']}\n${daysMap[days[2]][specialities[index]]['time']}',
                        ))));

                List<Widget> tuesdayList=List<Widget>.generate(tuesdayStrings.length, (index){

                  return Container(
                    color: curDay == days[3]?Colors.blue: Colors.transparent,
                    margin: EdgeInsets.all(1),
                    child: Center(
                        child: Text(
                          '${daysMap[days[3]][specialities[index]]['name']}\n${daysMap[days[3]][specialities[index]]['time']}',
                        )));});



                List<Widget> wednesdayList=List<Widget>.generate(wednesdayStrings.length, (index) => Container(
                    color: curDay == days[4]?Colors.blue: Colors.transparent,
                    margin: EdgeInsets.all(1),
                    child: Center(
                        child: Text(
                          '${daysMap[days[4]][specialities[index]]['name']}\n${daysMap[days[4]][specialities[index]]['time']}',
                        ))));

                List<Widget> thursdayList=List<Widget>.generate(thursdayStrings.length, (index) => Container(
                    color: curDay == days[5]?Colors.blue: Colors.transparent,
                    margin: EdgeInsets.all(1),
                    child: Center(
                        child: Text(
                          '${daysMap[days[5]][specialities[index]]['name']}\n${daysMap[days[5]][specialities[index]]['time']}',
                        ))));

                List<Widget> fridayList=List<Widget>.generate(fridayStrings.length, (index) => Container(
                    color: curDay == days[6]?Colors.blue: Colors.transparent,
                    margin: EdgeInsets.all(1),
                    child: Center(
                        child: Text(
                          '${daysMap[days[6]][specialities[index]]['name']}\n${daysMap[days[6]][specialities[index]]['time']}',
                        ))));



                ExpandableTableHeader header = ExpandableTableHeader(
                    hideWhenExpanded: true,
                    firstCell: Container(
                        color: Colors.teal,
                        margin: EdgeInsets.all(1),
                        child: Center(
                            child: Text(
                              'Day',
                              style: headerFontStyle
                            ))),
                    children: [
                      Container(
                          color: Colors.blueGrey,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'Cardiology',
                                style: headerFontStyle,
                              ))),
                      Container(
                          color: Colors.blueGrey,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'Dentistry',
                                style: headerFontStyle,
                              ))),
                      Container(
                          color: Colors.blueGrey,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'paediatrics',
                                style: headerFontStyle,
                              ))),
                      Container(
                          color: Colors.blueGrey,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'ophthalmology',
                                style: headerFontStyle,
                              ))),
                      Container(
                          color: Colors.blueGrey,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'orthopaedics',
                                style: headerFontStyle,
                              ))),

                    ]
                );



                List<ExpandableTableRow> rows = [
                  ExpandableTableRow(
                      height: 80,
                      firstCell: Container(
                          color: curDay == 'Saturday'?Colors.blue: Colors.transparent,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'Saturday',
                              ))),
                      children: saturdayList

                  ),
                  ExpandableTableRow(
                      height: 80,
                      firstCell: Container(
                          color: curDay == 'Sunday'?Colors.blue: Colors.transparent,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'Sunday',
                              ))),
                      children: sundayList

                  ),
                  ExpandableTableRow(
                      height: 80,
                      firstCell: Container(
                          color: curDay == 'Monday'?Colors.blue: Colors.transparent,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'Monday',
                              ))),
                      children: mondayList

                  ),
                  ExpandableTableRow(
                      height: 80,
                      firstCell: Container(
                          color: curDay == 'Tuesday'?Colors.blue: Colors.transparent,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'Tuesday',
                              ))),
                      children: tuesdayList

                  ),
                  ExpandableTableRow(
                      height: 80,
                      firstCell: Container(
                          color: curDay == 'Wednesday'?Colors.blue: Colors.transparent,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'Wednesday',
                              ))),
                      children: wednesdayList

                  ),
                  ExpandableTableRow(
                      height: 80,
                      firstCell: Container(
                          color: curDay == 'Thursday'?Colors.blue: Colors.transparent,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'Thursday',
                              ))),
                      children: thursdayList

                  ),
                  ExpandableTableRow(
                      height: 80,
                      firstCell: Container(
                          color: curDay == 'Friday'?Colors.blue: Colors.transparent,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                                'Friday',
                              ))),
                      children: fridayList

                  )
                ];


                return ExpandableTable(
                  cellHeight: 100,
                  cellWidth: 120,
                  firstColumnWidth: 100,
                  headerHeight: 80,
                  rows: rows,
                  header: header,
                  scrollShadowColor: Colors.blue,
                  scrollShadowCurve: Curves.bounceInOut,
                );
              }
          ),
        ),
      ),


    );
  }
}
