import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/models/user_model.dart';
import 'package:homemedica_patient/screens/home_screen.dart';
import 'package:homemedica_patient/screens/profile_page_screen/widgets/prfile_appbar.dart';
import 'package:homemedica_patient/services/database.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  UserModel userModel = Get.arguments;
  Database db = Database();
  AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> updateUserValue(String name)async {
    userModel.username =name;
    await db.updateUser(userModel,authController.firebaseUser.value!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildProfileAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: const Text(
                    "What's Your Name?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),

              Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                  child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextFormField(
                        // Handles Form Validation for Name
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration:
                        InputDecoration(labelText: 'Name'),
                        controller: nameController,
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
                          onPressed: () async{
                            await updateUserValue(nameController.text);
                            Get.offAll(()=>HomeScreen());
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }
}