import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel{

  late String bookerID;
  late String endTime;
  late Timestamp timeStamp;
  late bool isFinished;
  late String speciality;

  ReservationModel({required this.bookerID,required this.endTime,required this.timeStamp,required this.isFinished,required this.speciality});


  factory ReservationModel.fromJson(Map<String,dynamic> data){
    return ReservationModel(bookerID: data['bookerID'], endTime: data['endTime'], timeStamp: data['timeStamp'],
        isFinished: data['isFinished'],speciality: data['speciality']);
  }

  static Map<String,dynamic> toJson(ReservationModel model){
    return {
      'bookerID':model.bookerID,
      'endTime':model.endTime,
      'timeStamp':model.timeStamp,
      'isFinished':model.isFinished,
      'speciality':model.speciality
    };
  }

}