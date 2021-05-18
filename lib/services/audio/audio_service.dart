

import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AudioService {

  static AudioService? _instance;
  final FlutterTts _flutterTts = FlutterTts();
  AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();
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

  playFile(path, {volume = 1.0}) async {
    return await _player.open(
      Audio(path),
      autoStart: true,
      volume: volume
    );
  }

  speak(String text) async {
    if(_completer != null) return;
    _completer = Completer();
    await _flutterTts.speak(text);
    return _completer!.future;
  }

  listen() async {
    if(_completer != null) return;
    _completer = Completer();
    SpeechToText speech = SpeechToText();

    bool available = await speech.initialize( onStatus: (status){}, onError: (error){
      _completer!.complete(null);
      _completer = null;
    });
    final locales = await speech.locales();
    final locale = locales.firstWhere((element) => element.name == 'Portuguese (Brazil)');
    if ( available ) {
        speech.listen(localeId: locale.localeId, listenFor: Duration(seconds: 5),  onResult: (result){
          if(result.finalResult){
            _completer?.complete(result.recognizedWords);
            _completer = null;
          }
        } );

    }
    else {
        print("The user has denied the use of speech recognition.");
    }

    return _completer!.future;
  }


  static AudioService get instance {
    if(_instance == null) _instance = AudioService._();
    return _instance!;
  }
}