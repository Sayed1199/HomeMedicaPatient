
import 'package:homemedica_patient/constants.dart';

class UserModel{

  String id;
  String? username;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  String? fcmToken;

  UserModel({required this.id,required this.username,this.email,this.phoneNumber,this.imageUrl,required this.fcmToken});


  factory UserModel.getUserModelFromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username']==null?json['phoneNumber']:json['username'],
      email: json['email'],
      imageUrl: json['imageUrl']==null?anonPic:json['imageUrl'],
      phoneNumber: json['phoneNumber'],
      fcmToken: json['fcmToken']
    );
  }

  static Map<String,dynamic> userModelToJson(UserModel model){
    return {
      'id':model.id,
      'username':model.username,
      'email':model.email,
      'imageUrl':model.imageUrl,
      'phoneNumber':model.phoneNumber,
      'fcmToken':model.fcmToken
    };
  }

}