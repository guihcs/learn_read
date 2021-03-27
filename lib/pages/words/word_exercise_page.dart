

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class WordExercisePage extends StatefulWidget {
  @override
  _WordExercisePageState createState() => _WordExercisePageState();
}

class _WordExercisePageState extends State<WordExercisePage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        children: [
          Column(
            children: [
              ElevatedButton(onPressed: () async {
                FlutterTts flutterTts = FlutterTts();
                var result = await flutterTts.speak("Hello world");
                await flutterTts.awaitSpeakCompletion(true);



              }, child: Text('speak')),
              ElevatedButton(onPressed: () async {
                stt.SpeechToText speech = stt.SpeechToText();
                final locales = await speech.locales();
                final ln = locales.map((e) => e.name).toList();
                final brIndex = ln.indexWhere((element) => element.contains('Brazil'));

                bool available = await speech.initialize( onStatus: (status){}, onError: (error){} );
                if ( available ) {

                  speech.listen(
                    localeId: locales[brIndex].localeId,
                      onResult: (result){
                    if(result.finalResult) print(result);
                  });
                }
                else {
                  print("The user has denied the use of speech recognition.");
                }
                // some time later...
                Future.delayed(Duration(seconds: 5), (){
                  speech.stop();
                });

              }, child: Text('read'))
            ],
          )

        ],
      ),
    );
  }
}
