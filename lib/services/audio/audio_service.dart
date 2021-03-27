

import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

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


  static AudioService get instance {
    if(_instance == null) _instance = AudioService._();
    return _instance!;
  }
}