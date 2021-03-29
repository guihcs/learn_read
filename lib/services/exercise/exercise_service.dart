
import 'package:flutter/material.dart';
import 'package:learn_read/exercises/find_from_speak.dart';

class ExerciseConfig {
  final String name;
  final String correctOption;
  final String? currentSelected;
  final List<String> options;
  final Function(String)? onChanged;

  ExerciseConfig({required name, required correctOption, currentSelected, options = const [], onChanged}) :
    this.name = name,
    this.correctOption = correctOption,
    this.currentSelected = currentSelected,
    this.options = options,
    this.onChanged = onChanged
    ;
}


class ExerciseBuilder {
  static Widget build(ExerciseConfig config){
    switch(config.name){
      case 'findFromSpeak': return FindFromSpeakExercise(
        correct: config.correctOption,
        options: config.options,
        onSelectedChange: config.onChanged,
        currentSelected: config.currentSelected,
        );
      default: return Container(child: Text('Exercise not found.'));
    }
  }
}