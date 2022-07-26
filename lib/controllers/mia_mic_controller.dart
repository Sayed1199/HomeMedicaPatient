import 'package:get/get.dart';
import 'package:homemedica_patient/controllers/mia_chat_controller.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

MiaChatController chatController = Get.put(MiaChatController());

class MiaMicController extends GetxController{

  var isMicopen = Rx<bool>(false);
  SpeechToText _speechToText = SpeechToText();
  var lastWords = Rx<String>('');

  Future<void> openMic()async{
    isMicopen.value=true;
    await _speechToText.initialize();
    await _speechToText.listen(onResult: (SpeechRecognitionResult result){
      lastWords.value = result.recognizedWords;
    });
  }

  Future<void> closeMic()async{
    isMicopen.value=false;
    await _speechToText.stop();
    print('wordsss: ${lastWords.value}');
    //chatController.sendUserMessage(lastWords.value);

  }


}