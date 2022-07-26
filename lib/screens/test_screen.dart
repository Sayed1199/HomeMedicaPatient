import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:permission_handler/permission_handler.dart';


class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  // Instantiate the client
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: agoraAppID,
      channelName: agoraChannelName,
      tempToken: agoraTempToken
    ),
    enabledPermission: [Permission.camera, Permission.microphone],
    agoraEventHandlers: AgoraRtcEventHandlers(
      userJoined: (uid, elapsed) => print("CUSTOM USER JOIN: $uid"),
      userOffline: (uid, reason) => print("CUSTOM USER OFFLINE REASON $reason"),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initAgora();

  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   client.engine.destroy();
   client.engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(client: client,
              layoutType: Layout.floating,
            showAVState: true,
            ),
            AgoraVideoButtons(client: client),
          ],
        ),
      ),
    );

  }

}