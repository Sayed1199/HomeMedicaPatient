import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/mia_chat_controller.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/models/mia_message_model.dart';
import 'package:homemedica_patient/widgets/mia_chat_bubble.dart';
import 'package:homemedica_patient/widgets/mia_text_field.dart';
import 'dart:math';
class MiaChatScreen extends StatefulWidget {
  const MiaChatScreen({Key? key}) : super(key: key);

  @override
  State<MiaChatScreen> createState() => _MiaChatScreenState();
}

class _MiaChatScreenState extends State<MiaChatScreen> {

  ThemeController themeController = Get.put(ThemeController());
   MiaChatController chatController=Get.put(MiaChatController());
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  late FocusNode _textFieldFocusNode;
  late FocusNode bodyFocusNode;
  GlobalKey textFieldKey = GlobalKey();


  void sendWelcomingSentences()async{

    await chatController.sendAiMessage(welcomingSentences[Random().nextInt(welcomingSentences.length)]);
    await chatController.sendAiMessage(welcomingSentence2);
    await chatController.sendAiMessage(askingAboutAge[Random().nextInt(askingAboutAge.length)]);

/*
    Future.delayed(Duration(seconds: 1)).then((value) async{
        chatController.sendAiMessage(welcomingSentences[Random().nextInt(welcomingSentences.length)]);
    });
    Future.delayed(Duration(seconds: 6)).then((value) {
       chatController.sendAiMessage(welcomingSentence2);
    });

    Future.delayed(Duration(seconds: 12)).then((value) {
      chatController.sendAiMessage(askingAboutAge[Random().nextInt(askingAboutAge.length)]);
    });


 */


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    _textFieldFocusNode = FocusNode();
    bodyFocusNode = FocusNode();

    sendWelcomingSentences();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    _textFieldFocusNode.dispose();
    _scrollController.dispose();
    bodyFocusNode.dispose();
    chatController.TTSstop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        leading: BackButton(
          color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
        ),
        title: Text("Miya",style: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
        ),),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body:  GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(bodyFocusNode);
        },
        child: Stack(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [


                Flexible(
                  child: _Messages(
                    scrollController: _scrollController,
                    chatsController: chatController,
                    //chatData: mdata!,
                  ),
                ),

                BuildMiaTextField(key: textFieldKey,textFieldFocusNode: _textFieldFocusNode,chatsController: chatController,
                  textEditingController: _textEditingController,),

              ],
            ),


            /*
            Positioned(
              right: 0,
              bottom: 150,
              child: _ToBottom(controller: _scrollController),
            ),
            */

          ],
        ),
      ),

    );
  }
}

/*
class _ToBottom extends StatefulWidget {
  final ScrollController controller;
  const _ToBottom({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  __ToBottomState createState() => __ToBottomState();
}

class __ToBottomState extends State<_ToBottom> {


  @override
  void initState() {
    super.initState();




  }

  void onTap() {
    widget.controller.animateTo(widget.controller.position.minScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  /*
  Widget _buildIcon() {
    return Container(
      width: 70,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: CupertinoButton(
        color: Colors.transparent,
        padding: const EdgeInsets.all(0),
        onPressed: onTap,
        child: Container(
          child: Icon(Icons.arrow_drop_down_outlined,
              size: 20, color: Colors.blue),
          // padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              border:
              Border.all(color: Colors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return reachedThereshold ? _buildIcon() : Container(height: 0, width: 0);
  }
}
*/


class _Messages extends StatelessWidget {
   ScrollController scrollController;
  MiaChatController chatsController;
  _Messages({
    Key? key,
    required ScrollController scrollController,
    required this.chatsController,
  })  : scrollController = scrollController,
        super(key: key);




  Widget _buildMessageItem(MiaMessageModel message,
      //bool withoutAvatar, bool last,
      //bool first, bool isMiddle)
      ){
    return MiaChatBubble(
      message: message,
      withoutAvatar: false,
      isFromAi: message.isFromAI,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("Numbers: ${chatsController.length.value}");
      return ListView.separated(
        addAutomaticKeepAlives: true,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        reverse: true,
        padding:
        const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        //itemCount: chatData.messages.length,
        itemCount: chatsController.length.value,
        itemBuilder: (ctx, i) {
          return _buildMessageItem(
              chatsController.messagesList.value[i]);
             // ChatOps.withoutAvatar(i, chatsController.messagesList.value.length, chatsController.messagesList.value),
              //ChatOps.isLast(i,  chatsController.messagesList.value.length, chatsController.messagesList.value),
             // ChatOps.isFirst(i,  chatsController.messagesList.value.length, chatsController.messagesList.value),
            //  ChatOps.isMiddle(i,  chatsController.messagesList.value.length, chatsController.messagesList.value));
        },
        separatorBuilder: (_, i) {
          final msgs = chatsController.messagesList.value;
          int length = chatsController.messagesList.value.length;
          if ((i != length && msgs[i].isFromAI != msgs[i + 1].isFromAI))
            return SizedBox(height: 15);
          return SizedBox(height: 5);
        },

      );
    });
  }
}



class ChatOps {
  // show peer avatar only once in a series of messages

  static bool withoutAvatar(
      int i, int length, List<MiaMessageModel> messages) {
    bool c1 = i != 0 && messages[i - 1].isFromAI == false;
    return c1;
  }

  /*
  // for adding border radius to all sides except for bottomRight/bottomLeft
  // if last message in a series from same user
  static bool isLast(int i, int length, List<MiaMessageModel> messages) {
    bool c1 = i != 0 && messages[i - 1].isFromAI == messages[i].isFromAI;
    return i == length - 1 || c1;
  }

  // for adding border radius to only topLeft/bottomLeft or topRight/bottomRight
  // if message is in the series of messages of one user
  static bool isMiddle(int i, int length, List<MiaMessageModel> messages) {
    bool c1 = i != 0 && messages[i - 1].isFromAI == messages[i].isFromAI;
    bool c2 = i != length - 1 && messages[i + 1].isFromAI == messages[i].isFromAI;
    return c1 && c2;
  }

  // opposite of isLast
  static bool isFirst(int i, int length, List<MiaMessageModel> messages) {
    bool c1 = i != 0 && messages[i - 1].isFromAI == messages[i].isFromAI;
    bool c2 = i != length - 1 && messages[i + 1].isFromAI != messages[i].isFromAI;
    return i == 0 || (c1 && c2);
  }

   */
}

