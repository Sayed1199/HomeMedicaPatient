import 'dart:core';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/screens/home_screen.dart';
import 'package:homemedica_patient/screens/hospital_chat.dart';
import 'package:homemedica_patient/utils/signaling.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';


class VideoMeetingScreen extends StatefulWidget {

  const VideoMeetingScreen({Key? key}) : super(key: key);

  @override
  State<VideoMeetingScreen> createState() => _VideoMeetingScreenState();
}

class _VideoMeetingScreenState extends State<VideoMeetingScreen> {

  /*

  Signaling signaling= Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomID;

  */
  AuthController authController = Get.put(AuthController());
  ThemeController themeController = Get.put(ThemeController());




  AgoraClient? client;

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState

    /*
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream){
      _remoteRenderer.srcObject = stream;

      setState((){

      });

    });


    /*

    signaling.createRoom(_remoteRenderer,widget.callerID,widget.calleeID).then((id)async {
      roomID=id;
      //await signaling.joinRoom(id, _remoteRenderer);
      setState((){

      });
    });
    */

    signaling.openUserMedia(_localRenderer,_remoteRenderer);


    FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(authController.firebaseUser.value!.uid)
        .collection("rooms").get().then((value)async {
          if(_remoteRenderer != null){
            QuerySnapshot querySnapshot = await value;
            await signaling.joinRoom(querySnapshot.docs[0].id,_remoteRenderer);
            print("joined ${querySnapshot.docs[0].id}");

            if(mounted)
              setState((){

              });
          }else{
            print("null");
          }


    });

     */

    super.initState();

    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: agoraAppID,
          channelName: agoraChannelName,
          tempToken: agoraTempToken),
      enabledPermission: [Permission.camera, Permission.microphone],
      agoraEventHandlers: AgoraRtcEventHandlers(
        userJoined: (uid, elapsed) => print("CUSTOM USER JOIN: $uid"),
        userOffline: (uid, reason) =>
            print("CUSTOM USER OFFLINE REASON $reason"),
        leaveChannel: (state) {
          print("exited");
          return Get.offAll(()=>HomeScreen());
        },
      ),
    );

    if(client != null)
      initAgora();



  }

  void initAgora() async {
    setState((){
      loading=true;
    });
    await client!.initialize();
    if(mounted){
      setState((){
        loading=false;
      });
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose

   // _localRenderer.dispose();
   // _remoteRenderer.dispose();

    if(client != null){
      client!.engine.destroy();
      client!.engine.leaveChannel();
    }


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: !loading? client != null? SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(client: client!,
              layoutType: Layout.floating,
              showAVState: true,
            ),
            AgoraVideoButtons(client: client!,

            ),
          ],
        ),
      ):Center(
        child: LoadingWidget(),
      ):Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(color: Colors.blue,),
          ),
          SizedBox(height: 20,),
          Text('Please Wait...',style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.blue
          ),)
        ],
      )

    );

  }
}
