import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/models/list_item_expantion_model.dart';
import 'package:homemedica_patient/models/patient_model.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

bool finished=false;


class ClinicsScheduleScreen extends StatefulWidget {
  const ClinicsScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ClinicsScheduleScreen> createState() => _ClinicsScheduleScreenState();
}

class _ClinicsScheduleScreenState extends State<ClinicsScheduleScreen> {

  List<PatientModel> patientsList = [];
  /*
  [
    PatientModel(
        id: 1, name: "ssss", age: 22, finished: false),
    PatientModel(
        id: 2, name: "hhhh", age: 22, finished: false),
    PatientModel(
        id: 3, name: "mmmmm", age: 22, finished: false),
  ];

   */

  List<ListExpantionItem> clinicsList=[];
  /*
  [ListExpantionItem(text:"Clinic1",isExpanded:false,text2: 'Dr Ahmed'),
    ListExpantionItem(text:"Clinic2",isExpanded:false,text2: 'Dr so3ad'),ListExpantionItem(text:"Clinic3",isExpanded:false,text2: 'Dr hamada')];

   */
  ThemeController themeController = Get.put(ThemeController());

  List<dynamic> cardioListOffline=[];
  List<dynamic> dentListOffline=[];
  List<dynamic> pediaListOffline=[];
  List<dynamic> opthalListOffline=[];
  List<dynamic> orthoListOffline=[];
  List<dynamic> cardioListOnline=[];
  List<dynamic> dentListOnline=[];
  List<dynamic> pediaListOnline=[];
  List<dynamic> opthalListOnline=[];
  List<dynamic> orthoListOnline=[];

  List<String> specialities=["Cardiology", "Dentistry", "Pediatrics", "Ophthalmology", "Orthopaedics"];


  late PatientsDataSource offlineCardioPatientsDataSource =
  PatientsDataSource(patientsList: cardioListOffline);
  late PatientsDataSource offlineDentPatientsDataSource =
  PatientsDataSource(patientsList: dentListOffline);
  late PatientsDataSource offlinePediPatientsDataSource =
  PatientsDataSource(patientsList: pediaListOffline);
  late PatientsDataSource offlineOpthalPatientsDataSource =
  PatientsDataSource(patientsList: opthalListOffline);
  late PatientsDataSource offlineOrthoPatientsDataSource =
  PatientsDataSource(patientsList: orthoListOffline);

  late PatientsDataSource onlineCardioPatientsDataSource =
  PatientsDataSource(patientsList: cardioListOnline);
  late PatientsDataSource onlineDentPatientsDataSource =
  PatientsDataSource(patientsList: dentListOnline);
  late PatientsDataSource onlinePediPatientsDataSource =
  PatientsDataSource(patientsList: pediaListOnline);
  late PatientsDataSource onlineOpthalPatientsDataSource =
  PatientsDataSource(patientsList: opthalListOnline);
  late PatientsDataSource onlineOrthoPatientsDataSource =
  PatientsDataSource(patientsList: orthoListOnline);

  String curDay='';
  bool isOnline=false;

  Future<void> getClinicsList()async{
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection(HOSPITAL_TABLE_COLLECTION).doc(curDay.toUpperCase()).get();
    Map<String,dynamic> map =documentSnapshot.data() as Map<String,dynamic>;
    clinicsList.add(ListExpantionItem(text: 'Cardiology', isExpanded: false, text2: map['Cardiology']['name']));
    clinicsList.add(ListExpantionItem(text: 'Dentistry', isExpanded: false, text2: map['Dentistry']['name']));
    clinicsList.add(ListExpantionItem(text: 'Pediatrics', isExpanded: false, text2: map['Pediatrics']['name']));
    clinicsList.add(ListExpantionItem(text: 'Ophthalmology', isExpanded: false, text2: map['Ophthalmology']['name']));
    clinicsList.add(ListExpantionItem(text: 'Orthopaedics', isExpanded: false, text2: map['Orthopaedics']['name']));
  }

  Future<void> getClinicsForTodayOffline()async{
     curDay = DateFormat('EEEE').format(DateTime.now());


    getClinicsList();

    CollectionReference collectionReference = FirebaseFirestore.instance.collection(HOSPITAL_RESERVATIONS_COLLECTION);


    QuerySnapshot cardioSnapshot = await collectionReference.doc("Cardiology")
        .collection("OFFLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

     if(cardioSnapshot.size != 0){
       cardioSnapshot.docs.forEach((element){
         cardioListOffline.add(element.data());
       });
     }else{
       cardioListOffline = [];
     }

     QuerySnapshot dentSnapshot =
      await collectionReference.doc("Dentistry")
         .collection("OFFLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

     if(dentSnapshot.size != 0){
       dentSnapshot.docs.forEach((element) {
         dentListOffline.add(element.data());
       });
     }else{
       dentListOffline = [];
     }

     QuerySnapshot pediSnapshot =
      await collectionReference.doc("Pediatrics")
         .collection("OFFLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

     if(pediSnapshot.size != 0){
       pediSnapshot.docs.forEach((element) {
         pediaListOffline.add(element.data());
       });
     }else{
       pediaListOffline = [];
     }

     QuerySnapshot opthalSnapshot =
      await collectionReference.doc("Ophthalmology")
         .collection("OFFLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

     if(opthalSnapshot.size != 0){
       opthalSnapshot.docs.forEach((element) {
         opthalListOffline.add(element.data());
       });
     }else{
       opthalListOffline = [];
     }

     QuerySnapshot orthoSnapshot =
   await collectionReference.doc("Orthopaedics")
         .collection("OFFLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

     if(orthoSnapshot.size != 0){
       orthoSnapshot.docs.forEach((element) {
         orthoListOffline.add(element.data());
       });
     }else{
       orthoListOffline = [];
     }
     
     print('cardoOffline: $cardioListOffline');

  }

  Future<void> getClinicsForTodayOnline()async{
    curDay = DateFormat('EEEE').format(DateTime.now());


    CollectionReference collectionReference = FirebaseFirestore.instance.collection(HOSPITAL_RESERVATIONS_COLLECTION);


    QuerySnapshot cardioSnapshot =
    await collectionReference.doc("Cardiology")
        .collection("ONLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

    if(cardioSnapshot.size != 0){
      cardioSnapshot.docs.forEach((element){
        cardioListOnline.add(element.data());
      });
    }else{
      cardioListOnline = [];
    }

    QuerySnapshot dentSnapshot =
    await collectionReference.doc("Dentistry")
        .collection("ONLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

    if(dentSnapshot.size != 0){
      dentSnapshot.docs.forEach((element) {
        dentListOnline.add(element.data());
      });
    }else{
      dentListOnline = [];
    }

    QuerySnapshot pediSnapshot =
    await collectionReference.doc("Pediatrics")
        .collection("ONLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

    if(pediSnapshot.size != 0){
      pediSnapshot.docs.forEach((element) {
        pediaListOnline.add(element.data());
      });
    }else{
      pediaListOnline = [];
    }

    QuerySnapshot opthalSnapshot =
    await collectionReference.doc("Ophthalmology")
        .collection("ONLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

    if(opthalSnapshot.size != 0){
      opthalSnapshot.docs.forEach((element) {
        opthalListOnline.add(element.data());
      });
    }else{
      opthalListOnline = [];
    }

    QuerySnapshot orthoSnapshot =
    await collectionReference.doc("Orthopaedics")
        .collection("ONLINE").doc("DOCS").collection(curDay.toUpperCase()).get();

    if(orthoSnapshot.size != 0){
      orthoSnapshot.docs.forEach((element) {
        orthoListOnline.add(element.data());
      });
    }else{
      orthoListOnline = [];
    }

    print('cardoOnline: $cardioListOnline');



  }


  @override
  void initState(){
    super.initState();
    getClinicsForTodayOffline().then((value) {
      setState((){});
      getClinicsForTodayOnline();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: clinicsList!=null && clinicsList.isNotEmpty? NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                floating: true,
                pinned: false,
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Obx(()=>
                  Text(
                    "Clinics Today",
                    style: GoogleFonts.aBeeZee(
                        color: themeController.isDarkModeEnabled.value
                            ? Colors.grey[100]
                            : Colors.grey[900],
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ];
          },
          body: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0,5,0,5),
              child: ListView(
                children: [

                  Center(child: Text('$curDay   --    ${DateFormat('yMd').format(DateTime.now())}',style: GoogleFonts.lato(
                    fontSize: 18,
                    color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                  ),),),

                  SizedBox(height: 30,),

                  Center(
                    child: Container(
                      child: FlutterSwitch(
                        width: 210.0,
                        height: 60.0,
                        valueFontSize: 20.0,
                        toggleSize: 45.0,
                        value: isOnline,
                        borderRadius: 30.0,
                        padding: 8.0,
                        showOnOff: true,
                        inactiveText: "Offline Meeting",
                        activeText: "Online Meeting",
                        activeTextFontWeight: FontWeight.w300,
                        inactiveTextFontWeight: FontWeight.w400,
                        onToggle: (val) {
                          setState(() {
                            isOnline = val;
                          });
                          print("Value: ${isOnline}");
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 50,),

                  Container(
                    child: ExpansionPanelList(
                      dividerColor: Colors.blue.withOpacity(0.8),
                      animationDuration: Duration(milliseconds: 300),
                      elevation: 2,
                      expansionCallback: (int index, bool isExpaned) async{

                        /*
                        QuerySnapshot querySnapshot  = isOnline? await FirebaseFirestore.instance.collection(HOSPITAL_RESERVATIONS_COLLECTION)
                            .doc(specialities[index]).collection("ONLINE").doc("DOCS").collection(curDay.toUpperCase()).get():
                        await FirebaseFirestore.instance.collection(HOSPITAL_RESERVATIONS_COLLECTION)
                            .doc(specialities[index]).collection("OFFLINE").doc("DOCS").collection(curDay.toUpperCase()).get();
                       Map<String,dynamic> data = querySnapshot.docs[0].data() as Map<String,dynamic>;
                       */
                        setState(() {
                          //finished= data['isFinished'];
                          clinicsList[index].isExpanded =
                          !clinicsList[index].isExpanded;
                        });
                      },
                      children: clinicsList.map((ListExpantionItem item) {
                        return ExpansionPanel(
                          canTapOnHeader: true,
                            headerBuilder: (context, isExpanded) {
                              return Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Obx(()=>
                                    Text(
                                      '${item.text} - ${item.text2}',
                                      style: GoogleFonts.actor(
                                          fontSize: 20,
                                          color:themeController.isDarkModeEnabled.value
                                              ? Colors.grey[100]
                                              : Colors.grey[900],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ));
                            },
                            isExpanded: item.isExpanded,
                            body: Container(
                                child: SfDataGrid(
                                  isScrollbarAlwaysShown: true,
                                  gridLinesVisibility: GridLinesVisibility.both,
                                  headerGridLinesVisibility: GridLinesVisibility.both,
                                  columnWidthMode: ColumnWidthMode.fill,
                                source: item.text=="Cardiology"?isOnline?onlineCardioPatientsDataSource: offlineCardioPatientsDataSource:
                                  item.text=="Dentistry"?isOnline?onlineDentPatientsDataSource:offlineDentPatientsDataSource:
                                      item.text=="Pediatrics"?isOnline?onlinePediPatientsDataSource:offlinePediPatientsDataSource:
                                          item.text=="Ophthalmology"?isOnline?onlineOpthalPatientsDataSource:offlineOpthalPatientsDataSource:
                                              isOnline?onlineOrthoPatientsDataSource:offlineOrthoPatientsDataSource,
                                  columns: [
                                    GridColumn(
                                        columnName: "id",
                                        label: Container(
                                            margin: EdgeInsets.only(top: 15),
                                            //alignment: Alignment.centerRight,
                                            child: Text(
                                              'id',
                                              textAlign: TextAlign.center,
                                            ))),

                              GridColumn(
                                        columnName: "finished",
                                        label: Container(
                                            margin: EdgeInsets.only(top: 15),
                                            child: Text(
                                              'finished',
                                              textAlign: TextAlign.center,
                                            ))),

                                  ],
                                )));
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    :Center(
        child:LoadingWidget()
    )
    );
  }
}

class PatientsDataSource extends DataGridSource {
  PatientsDataSource({required List<dynamic> patientsList}) {
    _patients =  patientsList.map<DataGridRow>((e) {
      print('finished mow is: ${finished}');
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: "bookerID", value: e['bookerID']),
        DataGridCell<bool>(columnName: "finished", value: e['isFinished']),
      ]);
    }).toList();
  }

  List<DataGridRow> _patients = [];

  List<DataGridRow> get rows => _patients;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: row.getCells()[0].value == 3
            ? Colors.blue.withOpacity(0.5)
            : Colors.black.withOpacity(0.1),
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            margin: EdgeInsets.only(top:10.0),
            child: Text(
              dataGridCell.value.toString(),
              textAlign: TextAlign.center,
            ),
          );
        }).toList());
  }
}
