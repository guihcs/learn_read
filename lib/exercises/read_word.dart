import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:learn_read/services/audio/audio_service.dart';

class ReadWordExercise extends StatefulWidget {
  final String correct;
  final String? currentSelected;
  final List<String> options;
  final Function(String)? onSelectedChange;
  final bool visible;
  final DateTime exerciseTime;

  ReadWordExercise(
      {required this.correct,
      required this.options,
      required this.visible,
      required this.exerciseTime,
      this.currentSelected,
      this.onSelectedChange});

  @override
  _ReadWordExerciseState createState() => _ReadWordExerciseState();
}

class _ReadWordExerciseState extends State<ReadWordExercise> {
  bool _isListening = false;
  String _listenedText = '';

  @override
  void didUpdateWidget(covariant ReadWordExercise oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.exerciseTime != oldWidget.exerciseTime) {
      _isListening = false;
      _listenedText = '';
    }
  }

  @override
  void dispose() {
    _listenedText = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_correctTile(), _text(), _listenButton()],
    );
  }

  _correctTile() {
    return InkWell(
      onTap: () {
        AudioService.instance.speak(widget.correct);
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(widget.correct, style: TextStyle(fontSize: 28)),
      )),
    );
  }

  _text() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56.0),
      child: Text(
        _listenedText,
        style: TextStyle(fontSize: 28),
      ),
    );
  }

  _listenButton() {
    return ElevatedButton(
        style: _isListening ? ElevatedButton.styleFrom(primary: Colors.white) : null,
        onPressed: () async {
          if (_isListening) return;
          setState(() {
            _isListening = true;
          });
          String? result = await AudioService.instance.listen();
          setState(() {
            _isListening = false;
          });
          if (result == null) return;
          result = removeDiacritics(result).toLowerCase();
          String correct = removeDiacritics(widget.correct).toLowerCase();

          num similarity = _levenshtein(correct, result) / max(correct.length, result.length);

          if (widget.onSelectedChange != null) {
            String selected = similarity >= 0.5 ? correct : result;
            setState(() {
              _listenedText = selected;
            });
            widget.onSelectedChange!(selected);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.mic, color: _isListening ? Colors.black : Colors.white, size: 42),
        ));
  }

  _levenshtein(a, b) {
    var t = [], u, i, j, m = a.length, n = b.length;
    if (m <= 0) {
      return n;
    }
    if (n <= 0) {
      return m;
    }
    for (j = 0; j <= n; j++) {
      t.insert(j, j);
    }
    for (i = 1; i <= m; i++) {
      u = [i];
      for (j = 1; j <= n; j++) {
        u.insert(j, a[i - 1] == b[j - 1] ? t[j - 1] : min<int>(t[j - 1], min(t[j], u[j - 1])) + 1);
      }
      t = u;
    }
    return u[n];
  }
}
