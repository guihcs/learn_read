import 'package:flutter/material.dart';
import 'package:learn_read/exercises/find_from_speak.dart';
import 'package:learn_read/exercises/read_word.dart';
import 'package:learn_read/models/exercise/exercise_config.dart';

class ExerciseBuilder {
  static Widget build(ExerciseConfig config, {visible = false}) {
    switch (config.name) {
      case ExerciseTypes.findFromSpeak:
        return FindFromSpeakExercise(
          correct: config.correctOption,
          options: config.options,
          onSelectedChange: config.onChanged,
          currentSelected: config.currentSelected,
          exerciseTime: config.generationTime,
          visible: visible,
        );
      case ExerciseTypes.readWord:
        return ReadWordExercise(
          correct: config.correctOption,
          options: config.options,
          onSelectedChange: config.onChanged,
          currentSelected: config.currentSelected,
          exerciseTime: config.generationTime,
          visible: visible
        );
      default:
        return Container(child: Text('Exercise not found.'));
    }
  }
}
