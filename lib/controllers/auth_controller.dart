import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/models/user_model.dart';
import 'package:homemedica_patient/screens/home_screen.dart';
import 'package:homemedica_patient/screens/login_screen.dart';
import 'package:homemedica_patient/services/database.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';


class AuthController extends GetxController{

 FirebaseAuth auth = FirebaseAuth.instance;
 FirebaseFirestore fstore = FirebaseFirestore.instance;
 GoogleSignIn googleSignIn = GoogleSignIn();

 Database db = Database();

 late Rx<User?> firebaseUser;
 late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSignIn.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setScreensFromNormalUser);

    googleSignInAccount.bindStream(googleSignIn.onCurrentUserChanged);
    ever(googleSignInAccount, _setScreensFromGoogleUser); 

  }


  _setScreensFromNormalUser(User? user) async {
   if(user==null){
    Get.offAll(()=>LoginScreen());
   }else{
    Get.offAll(()=>HomeScreen(),arguments: 'hi');
   }
  }

  _setScreensFromGoogleUser(GoogleSignInAccount? googleUser) async {
   if(googleUser==null){
    Get.offAll(()=>LoginScreen());
   }else{
    Get.offAll(()=>HomeScreen(),arguments: 'hi');
   }
  }


 Future<void> signInWithGoogle() async {
  try {
   GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

   if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
     accessToken: googleSignInAuthentication.accessToken,
     idToken: googleSignInAuthentication.idToken,
    );

    await auth
        .signInWithCredential(credential)
        .catchError((onErr) => print(onErr));


    if(firebaseUser.value != null) {

     String? token = await FirebaseMessaging.instance.getToken();

     UserModel model = UserModel(id: firebaseUser.value!.uid,
      username: firebaseUser.value!.displayName == null?null:firebaseUser.value!.displayName,
      email: firebaseUser.value!.email != null?firebaseUser.value!.email! : null,
      imageUrl: firebaseUser.value!.photoURL != null?firebaseUser.value!.photoURL! : null,
      phoneNumber: firebaseUser.value!.phoneNumber != null?firebaseUser.value!.phoneNumber! : null,
      fcmToken: token
     );

     await db.addUser(model);

    }else{
     print('Null User');
    }


   }
  } catch (e) {
   Get.snackbar(
    "Error",
    e.toString(),
    snackPosition: SnackPosition.BOTTOM,
   );
   print(e.toString());
  }
 }




 Future<void> signInWFacebook()async{
  try{

   final fb = FacebookLogin();

   FacebookLoginResult res = await fb.logIn(permissions: [
    FacebookPermission.publicProfile,
    FacebookPermission.email,
   ]);


   // Check result status
   switch (res.status) {
    case FacebookLoginStatus.success:
    // Logged in

    print("Success");

    // Send access token to server for validation and auth
     final FacebookAccessToken accessToken = res.accessToken!;
     print('Access token: ${accessToken.token}');
     final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.token);
     await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

     final graphResponse = await http.get(Uri.parse(
         'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${accessToken.token}'));

     String imageUrl = jsonDecode(graphResponse.body)['picture']['data']['url'];
     String? token = await FirebaseMessaging.instance.getToken();

     UserModel model = UserModel(id: firebaseUser.value!.uid,
         username: firebaseUser.value!.displayName == null?null:firebaseUser.value!.displayName,
         email: firebaseUser.value!.email != null?firebaseUser.value!.email! : null,
         imageUrl: imageUrl != null? imageUrl : null,
         phoneNumber: firebaseUser.value!.phoneNumber != null?firebaseUser.value!.phoneNumber! : null,
         fcmToken: token
     );

     await db.addUser(model);

     // Get profile data
     final profile = await fb.getUserProfile();
     print('Hello, ${profile!.name}! You ID: ${profile.userId}');

     // Get user profile image url
     final MyimageUrl = await fb.getProfileImageUrl(width: 100);
     print('Your profile image: $MyimageUrl');

     // Get email (since we request email permission)
     final email = await fb.getUserEmail();
     // But user can decline permission
     if (email != null)
      print('And your email is $email');

     break;
    case FacebookLoginStatus.cancel:
    // User cancel log in
    fb.logOut();
     break;
    case FacebookLoginStatus.error:
    // Log in failed
     print('Error while log in: ${res.error}');
     break;
   }


   /*
   final LoginResult loginResult = await FacebookAuth.instance.login();
   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

   await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

   */



  }catch(e){
   Get.snackbar(
    "Error",
    e.toString(),
    snackPosition: SnackPosition.BOTTOM,
   );
   print(e.toString());
  }
 }


 Future<void> verifyCode(String? verificationId,String otpCode) async {
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!, smsCode: otpCode);
  await auth.signInWithCredential(credential).then((value) async{

   print('You Are Logged in');
   Fluttertoast.showToast(
       msg: 'Logged in successfully',
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       backgroundColor: Colors.blue);

   String? token = await FirebaseMessaging.instance.getToken();


   UserModel model = UserModel(id: firebaseUser.value!.uid,
    username: firebaseUser.value!.displayName == null?firebaseUser.value!.phoneNumber:firebaseUser.value!.displayName,
    email: firebaseUser.value!.email != null?firebaseUser.value!.email! : null,
    imageUrl: firebaseUser.value!.photoURL != null?firebaseUser.value!.photoURL! : anonPic,
    phoneNumber: firebaseUser.value!.phoneNumber != null?firebaseUser.value!.phoneNumber! : null,
    fcmToken: token
   );
   await db.addUser(model);
  });
 }

 Future<void> signOut()async{
   await auth.signOut();
 }

}