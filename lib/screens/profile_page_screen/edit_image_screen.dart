import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/models/user_model.dart';
import 'package:homemedica_patient/screens/home_screen.dart';
import 'package:homemedica_patient/screens/profile_page_screen/widgets/prfile_appbar.dart';
import 'package:homemedica_patient/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {

  UserModel userModel = Get.arguments;
  AuthController authController = Get.put(AuthController());
  Database db = Database();

  String? url;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildProfileAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: const Text(
                "Upload a photo",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          SizedBox(height: 30,),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                       url = await uploadImageToFirebase(File(image.path), authController.firebaseUser.value!.uid);


                      if(url == null){
                        print('null');
                      }else{
                        print('url is: $url');
                      }


                      ///////

                      setState(() {
                              });
                    },
                    child: Image.network(userModel.imageUrl!),
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),

                        )),
                      ),
                      onPressed: ()async {
                        if(url != null) {
                          userModel.imageUrl = url;
                          //authController.firebaseUser.value!.updatePhotoURL(url);
                          await db.updateUser(userModel,
                              authController.firebaseUser.value!.uid);
                          Get.offAll(()=>HomeScreen());
                        }
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }

  Future<String?> uploadImageToFirebase(File image,String id)async{

    Reference reference = FirebaseStorage.instance
        .ref()
        .child('profileImages/$id/profileImage');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    print(imageUrl);
    return imageUrl;

  }

}