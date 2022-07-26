import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/models/reservation_model.dart';
import 'package:intl/intl.dart';

class Utils{


  Future<List<ReservationModel>> getBookingsListOffline()async{
    String curDay = DateFormat('EEEE').format(DateTime.now());
    List<String> specialities = ["Cardiology", "Dentistry", "Pediatrics", "Ophthalmology", "Orthopaedics"];
    AuthController authController = Get.put(AuthController());

    List<ReservationModel> myList=[];

    CollectionReference ref = FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(authController.firebaseUser.value!.uid)
    .collection("BOOKINGS");

    specialities.forEach((element) async{
     QuerySnapshot querySnapshot = await ref.doc(element).collection("RESERVATIONS").doc(curDay.toUpperCase()).collection("OFFLINE_BOOKINGS").get();
    querySnapshot.docs.forEach((element) {
      myList.add(ReservationModel.fromJson(element.data() as Map<String,dynamic>));
    });
    });

    return myList;

  }

  Future<List<ReservationModel>> getBookingsListOnline()async{
    String curDay = DateFormat('EEEE').format(DateTime.now());
    List<String> specialities = ["Cardiology", "Dentistry", "Pediatrics", "Ophthalmology", "Orthopaedics"];
    AuthController authController = Get.put(AuthController());

    List<ReservationModel> myList=[];

    CollectionReference ref = FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(authController.firebaseUser.value!.uid)
        .collection("BOOKINGS");

    specialities.forEach((element) async{
      QuerySnapshot querySnapshot = await ref.doc(element).collection("RESERVATIONS").doc(curDay.toUpperCase()).collection("ONLINE_BOOKINGS").get();
      querySnapshot.docs.forEach((element) {
        myList.add(ReservationModel.fromJson(element.data() as Map<String,dynamic>));
      });
    });

    return myList;

  }

  Future<QuerySnapshot<Map<String, dynamic>>> getHospitalTable(){
    return FirebaseFirestore.instance.collection(HOSPITAL_TABLE_COLLECTION).get();
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> getHospitalChatStream(){
    AuthController authController = Get.put(AuthController());
    return FirebaseFirestore.instance.collection(HOSPITAL_CHATS_COLLECTION).doc(authController.firebaseUser.value!.uid)
        .collection('MESSAGES').orderBy('timestamp',descending: true).snapshots();
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> getDiagnosisHistoryStream(){
    AuthController authController = Get.put(AuthController());
    return FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(authController.firebaseUser.value!.uid)
        .collection(PATIENT_DIAGNOSIS_HISTORY).snapshots();
  }


}