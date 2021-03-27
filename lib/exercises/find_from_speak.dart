import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn_read/services/audio/audio_service.dart';

class FindFromSpeakExercise extends StatefulWidget {

  final String _correct;
  final String? _currentSelected;
  final List<String> _options;
  final Function(String)? _onSelectedChange;

  FindFromSpeakExercise({required correct, required options, currentSelected, onSelectedChange}) :
      _correct = correct,
      _currentSelected = currentSelected,
      _options = options,
      _onSelectedChange = onSelectedChange;


  @override
  _FindFromSpeakExerciseState createState() => _FindFromSpeakExerciseState();
}

class _FindFromSpeakExerciseState extends State<FindFromSpeakExercise> {

  bool _isSpeaking = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () => _speak(widget._correct), child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.volume_up, size: 24,),
        )),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          padding: EdgeInsets.all(32),
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          children: List.generate(widget._options.length, (index) {
            return Card(
              color: widget._currentSelected == widget._options[index] ? Colors.lightBlueAccent[200] : Colors.white,
              child: InkWell(
                onTap: (){
                  _speak(widget._options[index]);
                  if(widget._onSelectedChange != null){
                    widget._onSelectedChange!(widget._options[index]);
                  }
                },
                child: Center(
                  child: Text(
                    widget._options[index],
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black
                  ),
              ),
                ),
              ),
            );
          }),
        )
      ],
    );
  }


  _speak(text) async {
    if(_isSpeaking) return;
    setState(() {
      _isSpeaking = true;
    });
    await AudioService.instance.speak(text);

    setState(() {
      _isSpeaking = false;
    });
  }
}
