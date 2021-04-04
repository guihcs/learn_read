
import 'package:flutter/material.dart';
import 'package:learn_read/exercises/find_from_speak.dart';
import 'package:learn_read/models/exercise/exercise_config.dart';




class ExerciseBuilder {
  static Widget build(ExerciseConfig config){
    switch(config.name){
      case ExerciseTypes.findFromSpeak: return FindFromSpeakExercise(
        correct: config.correctOption,
        options: config.options,
        onSelectedChange: config.onChanged,
        currentSelected: config.currentSelected,
        );
      default: return Container(child: Text('Exercise not found.'));
    }
  }
}