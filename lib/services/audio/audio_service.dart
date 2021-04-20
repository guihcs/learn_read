

import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AudioService {

  static AudioService? _instance;
  final FlutterTts _flutterTts = FlutterTts();
  Completer? _completer;

  AudioService._(){
    _flutterTts.setLanguage('pt-BR');
    _flutterTts.setCompletionHandler(() {
      if(_completer != null){
        _completer!.complete();
        _completer = null;
      }
    });
  }

  speak(String text) async {
    if(_completer != null) return;
    await _flutterTts.speak(text);
    _completer = Completer();
    return _completer!.future;
  }

  listen() async {
    SpeechToText speech = SpeechToText();
    bool available = await speech.initialize( onStatus: (status){}, onError: (error){} );
    if ( available ) {
        speech.listen( onResult: (result){
          
        } );
    }
    else {
        print("The user has denied the use of speech recognition.");
    }

    speech.stop();
  }


  static AudioService get instance {
    if(_instance == null) _instance = AudioService._();
    return _instance!;
  }
}