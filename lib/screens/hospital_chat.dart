import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/controllers/hospital_chat_keyboard_controller.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/utils/utils.dart';
import 'package:homemedica_patient/widgets/message_bubble.dart';
import 'package:http/http.dart' as http;


FirebaseFirestore _firestore = FirebaseFirestore.instance;
ThemeController themeController = Get.put(ThemeController());
AuthController authController = Get.put(AuthController());

class HospitalChatScreen extends StatefulWidget {
  const HospitalChatScreen({Key? key}) : super(key: key);

  @override
  State<HospitalChatScreen> createState() => _HospitalChatScreenState();
}

class _HospitalChatScreenState extends State<HospitalChatScreen> {

  final focusNode = FocusNode();
  final controller = TextEditingController();
  var messageText;



  late KeyboardVisibilityController keyboardVisibilityController;

  HospitalChatKeyboardController keyboardController = Get.put(HospitalChatKeyboardController());


  ////////////////////////////////////////////////////

  String? mtoken = " ";
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
      });
    });
  }


  void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  Future<void> sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAa9QZIbU:APA91bEPx-aXGT6BsBTyGGg4qHJAuS-Zg1dz0IdHRtNQW4sq1Wvb9W5Z-QjTyxLwuzILSRKMoxEMG5-TEkqxEMHtMB2ig1r20eCoeYcHwGq-FzmzKkrggO_9o_xA0f-lzS5-Kw9rdVVp',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  //////////////////////////////////////////////////////


  @override
  void initState(){
    super.initState();
    keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {

      keyboardController.isKeyboardVisible.value=isKeyboardVisible;
      print('Changed keyboard');

      if (isKeyboardVisible && keyboardController.isEmojiVisible.value==true) {
        keyboardController.isEmojiVisible.value=false;
        print('Changed emoji to false');

      }
    });

    requestNotificationPermission();
    getToken();
    loadFCM();
    listenFCM();

  }



  Future toggleEmojiKeyboard() async {
    if (keyboardController.isKeyboardVisible.value) {
      FocusScope.of(context).unfocus();
    }
    keyboardController.isEmojiVisible.value = !keyboardController.isEmojiVisible.value;
    print('emoji value: ${keyboardController.isEmojiVisible.value}');
  }



  void onEmojiSelected(String emoji) => setState(() {
    controller.text = controller.text + emoji;
  });

  void onClickedEmoji() async {
    if (keyboardController.isEmojiVisible.value==true) {
      focusNode.requestFocus();
      print('emoji is true');
    } else if (keyboardController.isKeyboardVisible.value) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
    toggleEmojiKeyboard();
  }

  Widget buildSticker() {
    return Expanded(
      child: EmojiPicker(

        onEmojiSelected: (emoji, category) {
          onEmojiSelected(category.emoji);
        },
        config: Config(
          columns: 6,
          buttonMode: ButtonMode.MATERIAL,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context,value){
            return [
              SliverAppBar(
                floating: true,
                pinned: false,
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Obx(()=>
                    Text("Hospital Chat",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                    ),),
                ),
              ),
            ];
          },
          body: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      /*
                      Center(
                        child:
                      ),

                      SizedBox(height: 10,),
                      */

                      MessagesStream(),

                      Obx(()=>
                         Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                            height: 55.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(50),
                                color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]),
                            child: Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Obx(()=>
                                      IconButton(
                                        icon: Icon(keyboardController.isEmojiVisible.value
                                            ? Icons.keyboard_rounded
                                            : Icons.emoji_emotions,size: 30,),
                                        onPressed: onClickedEmoji,
                                        color: themeController.isDarkModeEnabled.value?Colors.blueGrey:Colors.grey[100],
                                      ),
                                  ),


                                  Flexible(
                                    child: Obx(()=>
                                        Container(
                                          child: TextField(
                                            textInputAction: TextInputAction.send,
                                            keyboardType: TextInputType.multiline,
                                            focusNode: focusNode,
                                            onSubmitted: (value) async{

                                              await sendMessage(controller, controller.text);


                                            },
                                            maxLines: null,
                                            controller: controller,
                                            onChanged: (value) {
                                              messageText = value;
                                            },
                                            style: TextStyle(fontSize: 15,color: themeController.isDarkModeEnabled.value?Colors.blueGrey:Colors.grey[100]),
                                            decoration:  InputDecoration.collapsed(
                                              hintText: 'Type Something...',
                                              hintStyle: TextStyle(color: themeController.isDarkModeEnabled.value?Colors.blueGrey:Colors.grey[100]),
                                            ),
                                          ),
                                        ),
                                    ),
                                  ),

                                  Obx(()=>
                                      IconButton(
                                        icon: Icon(Icons.send_rounded,size: 35,),
                                        onPressed: () async{
                                          await sendMessage(controller, controller.text);
                                        },
                                        color: themeController.isDarkModeEnabled.value?Colors.blueGrey:Colors.grey[100],
                                      ),
                                  ),


                                ],
                              ),
                            )
                        ),
                      ),

                      Obx(()=> keyboardController.isEmojiVisible.value==true ? buildSticker() : Container()),


                    ],
                  ),
                ),
        ),
            );
  }

  Future<void> sendMessage(TextEditingController controller, String text) async {
    if (controller.text.isNotEmpty) {
      await _firestore.collection(HOSPITAL_CHATS_COLLECTION).doc(
          authController.firebaseUser.value!.uid)
          .collection('MESSAGES').add({
        'sender': authController.firebaseUser.value!.email,
        'text': text,
        'timestamp': Timestamp.now(),
      }).then((value) {
        print('Added ID: ${value.id}');
      });
      print("token is: $mtoken");
      DocumentSnapshot documentSnapshot =await FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(authController.firebaseUser.value!.uid)
      .get();
      String t = (documentSnapshot.data() as Map<String,dynamic>)['fcmToken'];
      print('t is: $t');
      //await sendPushMessage(text, authController.firebaseUser.value!.email!, t);
      controller.clear();


    } else {
      Fluttertoast.showToast(msg: "Sorry can't send empty messages.",toastLength: Toast.LENGTH_SHORT,textColor: Colors.white,
          backgroundColor: Colors.blue,fontSize: 18);
    }
  }

}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: Utils().getHospitalChatStream(),
        builder: (context,snapshot) {
          if (!snapshot.hasData) {
            return Expanded(
              child: Center( 
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.data != null ) {

            
            if(snapshot.data!.docs.isEmpty){

              return Expanded(
                child: Center(
                  child: Obx(()=>
                      Text("No Messages yet.", style: GoogleFonts.lato(
                          fontSize: 20,
                          color: themeController.isDarkModeEnabled.value ? Colors
                              .grey[100] : Colors.grey[900]
                      ),),
                  ),
                ),
              );

            }
            else {
             
              List<Widget> messagesWidgets = snapshot.data!.docs.map<Widget>((
                  message) {
                final data = message.data() as dynamic;
                final messageText = data['text'];
                final messageSender = data['sender'];
                final currentUser = authController.firebaseUser.value!.email;
                final timeStamp = data['timestamp'];

                return MessageBubble(
                  sender: messageSender,
                  text: messageText,
                  timestamp: timeStamp,
                  isMe: currentUser == messageSender,
                );
              }).toList();


              return Expanded(
                child: ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  children: messagesWidgets,
                ),
              );
            }

          } else {
            return Expanded(
              child: Center(
                child: Obx(()=>
                  Text("No Messages yet.", style: GoogleFonts.lato(
                      fontSize: 20,
                      color: themeController.isDarkModeEnabled.value ? Colors
                          .grey[100] : Colors.grey[900]
                  ),),
                ),
              ),
            );
          }
        }

          );
    }
  }


