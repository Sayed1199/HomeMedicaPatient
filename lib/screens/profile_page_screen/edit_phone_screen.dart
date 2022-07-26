import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/models/user_model.dart';
import 'package:homemedica_patient/screens/home_screen.dart';
import 'package:homemedica_patient/screens/profile_page_screen/widgets/prfile_appbar.dart';
import 'package:homemedica_patient/services/database.dart';
import 'package:string_validator/string_validator.dart';

class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  UserModel userModel = Get.arguments;
  Database db = Database();
  AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> updateUserValue(String phone) async{

    userModel.phoneNumber = phone;
    await db.updateUser(userModel, authController.firebaseUser.value!.uid);

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
                      "What's Your Phone Number?",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (isAlpha(value)) {
                              return 'Only Numbers Please';
                            } else if (value.length < 10) {
                              return 'Please enter a VALID phone number';
                            }
                            return null;
                          },
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Your Phone Number',
                          ),
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

                             await updateUserValue(phoneController.text);

                              Get.offAll(()=>HomeScreen());

                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}