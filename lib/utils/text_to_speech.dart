
import 'package:flutter_tts/flutter_tts.dart';

class MyTextToSpeech{

  final FlutterTts tts = FlutterTts();

  MyTextToSpeech(){
    //tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    tts.setVolume(1.0);
    tts.setPitch(1.0);
    tts.awaitSpeakCompletion(true);
    //tts.setVoice({"name": "Karen", "locale": "en-US"});

  }

   speak(String text)async{

   await tts.speak(text);

  }

  void stop(){
    tts.stop();
  }

}

