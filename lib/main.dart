import 'package:flutter/material.dart';
import 'package:learn_read/pages/home.dart';
import 'package:learn_read/pages/letters/letter_exercise_page.dart';
import 'package:learn_read/pages/syllables/syllable_exercise_page.dart';
import 'package:learn_read/pages/words/word_exercise_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'letterExercise': (context) => LetterExercisePage(),
        'syllableExercise': (context) => SyllableExercisePage(),
        'wordExercise': (context) => WordExercisePage()
      },
    );
  }
}

