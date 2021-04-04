import 'dart:math';

import 'package:learn_read/models/exercise/exercise_config.dart';
import 'package:learn_read/models/user/word_competency.dart';
import 'package:learn_read/services/exercise/user_progress_service.dart';
import 'package:collection/collection.dart';

class ExerciseGenerator {
  static answerQuestion(data) {}

  static generate(count, maxRepeatedCount) {
    final competencyList = _getCompetencyList(count, maxRepeatedCount);

    return competencyList.map<ExerciseConfig>((entry) {
      return ExerciseConfig(
          name: ExerciseTypes.findFromSpeak,
          correctOption: entry.key,
          options: _getOptions(entry.key, 4));
    }).toList();
  }

  static _getCompetencyList(count, maxRepeatedCount) {
    Map<String, Competencies> competencies =
        UserProgressService.wordCompetencies;

    final exercises = [];
    Random random = Random();

    while (exercises.length < count) {
      MapEntry<String, dynamic>? exercise = competencies.entries
          .firstWhereOrNull(
              (element) => random.nextDouble() < element.value.total);

      if (exercise == null) continue;
      final exerciseRepeatedCount = exercises.fold<int>(
          0,
          (previousValue, element) =>
              element.key == exercise.key ? previousValue + 1 : previousValue);

      if (exerciseRepeatedCount < maxRepeatedCount) exercises.add(exercise);
    }

    return exercises;
  }

  static _getOptions(correct, count) {
    Random random = Random();
    Map<String, Competencies> competencies =
        UserProgressService.wordCompetencies;
    final options = <String>[];
    final words = competencies.keys.toList();
    for (int i = 0; i < words.length; i++) {
      if(options.length >= count - 1) break;
      if (words[i].length != correct.length ||
          words[i] == correct ||
          random.nextDouble() < 0.5) continue;

      options.add(words[i]);
    }
    options.add(correct);
    return options;
  }
}
