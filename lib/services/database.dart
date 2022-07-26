import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/models/user_model.dart';

class Database{

  final _fstore = FirebaseFirestore.instance;

  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection(USERS_COLLECTION);

  Future<void> addUser(UserModel model)async{
    try{
      _usersCollection.doc(model.id).set(UserModel.userModelToJson(model),SetOptions(merge: true));
    }catch(e){
      print('Add User error: $e');
    }
  }

  Future<void> updateUser(UserModel userModel,String uid)async{

    Map<String,dynamic> map = UserModel.userModelToJson(userModel);
    _usersCollection.doc(uid).set(map,SetOptions(merge: true));

  }



}