import 'package:flutter/material.dart';
import 'package:learn_read/services/audio/audio_service.dart';

class FindFromSpeakExercise extends StatefulWidget {
  final String _correct;
  final String? _currentSelected;
  final List<String> _options;
  final Function(String)? _onSelectedChange;

  FindFromSpeakExercise(
      {required correct, required options, currentSelected, onSelectedChange})
      : _correct = correct,
        _currentSelected = currentSelected,
        _options = options,
        _onSelectedChange = onSelectedChange;

  @override
  _FindFromSpeakExerciseState createState() => _FindFromSpeakExerciseState();
}

class _FindFromSpeakExerciseState extends State<FindFromSpeakExercise> {
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _speak(widget._correct);
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
      EdgeInsets padding = EdgeInsets.symmetric(
          horizontal: mw > mh ? pad : 0, vertical: mh > mw ? pad : 0);

      return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        padding: padding,
        children: List.generate(4, (index) {
          return _card(widget._options[index]);
        }),
      );
    });
  }

  _speakButton() {
    return ElevatedButton(
        onPressed: () => _speak(widget._correct),
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
      color: widget._currentSelected == option
          ? Colors.lightBlueAccent[200]
          : Colors.white,
      child: InkWell(
        onTap: () {
          _speak(option);
          if (widget._onSelectedChange != null) {
            widget._onSelectedChange!(option);
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
