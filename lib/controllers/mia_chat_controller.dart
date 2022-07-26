import 'package:homemedica_patient/utils/text_to_speech.dart';
import 'package:get/get.dart';
import 'package:homemedica_patient/models/mia_message_model.dart';

class MiaChatController extends GetxController{

  var messagesList=Rx<List<MiaMessageModel>>([]);
  var length = Rx<int>(0);
  var isAiEnabled = Rx<bool>(false);


  /*
  late TextToSpeech  flutterTts;
  double rate = 1.0;
  double volume = 1.0;
  double pitch = 1.0;
  bool initialized=false;
*/
  @override
  void onReady(){
    super.onReady();
     //flutterTts = TextToSpeech();
  }


   TTSspeak(String text)async{

    await MyTextToSpeech().speak(text);
    /*
    await flutterTts.setVolume(volume);
     await flutterTts.setRate(rate);
     await flutterTts.setPitch(pitch);
     //await flutterTts.setLanguage("en-US");

    print('speaking');
    if (text != null) {
      if (text.isNotEmpty) {
           await flutterTts.speak(text);
      }
    }
    */
  }

  TTSstop()async{
    MyTextToSpeech().stop();
  }

   sendAiMessage(String msg)async{
    isAiEnabled.value=true;
    messagesList.value.insert(0,MiaMessageModel(message: msg, isFromAI: true));
    length.value++;
    isAiEnabled.value=false;
    await  TTSspeak(msg);
   }
  void sendUserMessage(String msg){
    messagesList.value.insert(0,MiaMessageModel(message: msg, isFromAI: false));
    length.value++;
    print('list: ${messagesList.value[0].message}');
  }




}