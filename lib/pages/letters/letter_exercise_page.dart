

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_read/exercises/find_from_speak.dart';

class LetterExercisePage extends StatefulWidget {
  @override
  _LetterExercisePageState createState() => _LetterExercisePageState();
}

class _LetterExercisePageState extends State<LetterExercisePage> with SingleTickerProviderStateMixin {

  dynamic _currentSelected;
  dynamic _correct = 'A';
  bool? _isCorrect;






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                title: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    value: 0.5,
                  ),
                ),
              ),
              Expanded(
                child: FindFromSpeakExercise(
                  correct: 'A',
                  options: ['A', 'E', 'I', 'O'],
                  currentSelected: _currentSelected,
                  onSelectedChange: (value){
                    setState(() {
                      _currentSelected = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: ConfirmButton()
              )
            ],
          ),
        ),
      ),
    );
  }


  _shakeAnimation(child){
    double value = Curves.ease.transform(_controller.value);
    return Transform.translate(
      offset: Offset(cos(3 * pi * value) * 30 * (1 - value), 0),
      child: child,);
  }

  _wrongAnswerAnimation(){
    setState(() {
      _isCorrect = false;
      _controller.forward(from: 0);
    });
  }

  _correctAnswerAnimation(){
    setState(() {
      _isCorrect = true;
      _controller.forward();
    });
  }
}


class ConfirmButton extends StatefulWidget {

  final bool? _isCorrect;
  ConfirmButton({isCorrect}) : _isCorrect = isCorrect;

  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> with SingleTickerProviderStateMixin{

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        child = Card(
          color: _isCorrect ?? true ?Colors.blueAccent : Color.lerp(Colors.redAccent, Colors.blueAccent, _controller.value),
          child: InkWell(
            onTap: _currentSelected != null ? (){
              _currentSelected == _correct ? _correctAnswerAnimation() : _wrongAnswerAnimation();
            } : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Icon(Icons.check, size: 32, color: _isCorrect ?? true ? Colors.white : Color.lerp(Colors.black, Colors.white, _controller.value),),
            ),
          ),

        );
        return _isCorrect ?? true ? child : _shakeAnimation(child);
      },

    );
  }
}
