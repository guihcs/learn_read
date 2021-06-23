import 'package:flutter/material.dart';
import 'package:learn_read/services/audio/audio_service.dart';

class FindFromSpeakExercise extends StatefulWidget {
  final String correct;
  final String? currentSelected;
  final List<String> options;
  final Function(String)? onSelectedChange;
  final bool visible;
  final DateTime exerciseTime;

  FindFromSpeakExercise(
      {required this.correct,
      required this.options,
      required this.visible,
      required this.exerciseTime,
      this.currentSelected,
      this.onSelectedChange});

  @override
  _FindFromSpeakExerciseState createState() => _FindFromSpeakExerciseState();
}

class _FindFromSpeakExerciseState extends State<FindFromSpeakExercise> {
  bool _isSpeaking = false;
  bool _spoke = false;

  @override
  void initState() {
    super.initState();
    if(!_spoke && widget.visible){
      _speak(widget.correct);
      _spoke = true;
    }
  }

  @override
  void didUpdateWidget(covariant FindFromSpeakExercise oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.exerciseTime != oldWidget.exerciseTime){
      _spoke = false;
    }
    if (widget.visible && !_spoke) {
      _speak(widget.correct);
      _spoke = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _spoke = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _speakButton(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: _optionsGrid(),
          ),
        )
      ],
    );
  }

  _optionsGrid() {
    return LayoutBuilder(builder: (context, constraints) {
      double mh = constraints.maxHeight;
      double mw = constraints.maxWidth;
      double pad = (mh - mw).abs() / 2;
      EdgeInsets padding = EdgeInsets.symmetric(horizontal: mw > mh ? pad : 0, vertical: mh > mw ? pad : 0);

      return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        padding: padding,
        children: List.generate(4, (index) {
          return _card(widget.options[index]);
        }),
      );
    });
  }

  _speakButton() {
    return ElevatedButton(
        onPressed: () => _speak(widget.correct),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            Icons.volume_up,
            size: 24,
          ),
        ));
  }

  _card(option) {
    return Card(
      color: widget.currentSelected == option ? Colors.lightBlueAccent[200] : Colors.white,
      child: InkWell(
        onTap: () {
          _speak(option);
          if (widget.onSelectedChange != null) {
            widget.onSelectedChange!(option);
          }
        },
        child: Center(
          child: Text(
            option,
            style: TextStyle(fontSize: 32, color: Colors.black),
          ),
        ),
      ),
    );
  }

  _speak(text) async {
    if (_isSpeaking) return;
    setState(() {
      _isSpeaking = true;
    });
    await AudioService.instance.speak(text);

    if (mounted)
      setState(() {
        _isSpeaking = false;
      });
  }
}
