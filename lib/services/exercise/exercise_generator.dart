import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:learn_read/models/exercise/exercise_config.dart';
import 'package:learn_read/models/user/word_competency.dart';
import 'package:learn_read/services/exercise/user_progress_service.dart';
import 'package:collection/collection.dart';

class ExerciseGenerator {
  static answerQuestion(ExerciseConfig config) {
    config.responded = true;
    num lr = UserProgressService.learningRate;
    String response = config.currentSelected ?? '';
    if (config.correctOption != response) {
      lr *= -1;
    } else {
      UserProgressService.learningRate *= 1.1;
    }

    UserProgressService.currentProgress += lr * 10;

    _updateWordCompetencies(response, lr);
  }

  static _updateWordCompetencies(response, learningRate) {
    String filteredResponse = removeDiacritics(response);

    filteredResponse.split('').forEach((element) {
      _updateWordSetCompetencies(element, response, learningRate);
    });

    num total = UserProgressService.wordCompetencies[response]!.total;
    num exerciseCompetence =
        _calcNewCompetence(total, learningRate * -1, response);
    UserProgressService.wordCompetencies[response]!.total = exerciseCompetence;
  }

  static _updateWordSetCompetencies(char, response, lr) {
    Set<String>? wordsThatContainsChar =
        UserProgressService.wordMap.getWordSet(char);
    if (wordsThatContainsChar == null) return;
    wordsThatContainsChar.forEach((word) {
      if (word == response) return;
      num lastCompetence = UserProgressService.wordCompetencies[word]!.total;
      num wordLearningRate = word.length <= response.length ? lr * -1 : lr;
      num newCompetence =
          _calcNewCompetence(lastCompetence, wordLearningRate, word);
      UserProgressService.wordCompetencies[word]!.total = newCompetence;
    });
  }

  static _calcNewCompetence(previous, learnRate, w) {
    previous += learnRate / w.length;
    if (previous <= 0)
      previous = 0;
    else if (previous < 0.005)
      previous = 0.005;
    else if (previous > 1) previous = 1;
    return previous;
  }

  static List<ExerciseConfig> generate(count, maxRepeatedCount) {
    final competencyList = _getCompetencyList(count, maxRepeatedCount, 50);
    Random random = Random();
    return competencyList.map<ExerciseConfig>((entry) {
      return ExerciseConfig(
          name: ExerciseTypes.all[random.nextInt(ExerciseTypes.all.length)],
          correctOption: entry.key,
          options: _getOptions(entry.key, 4));
    }).toList();
  }

  static _getCompetencyList(count, maxRepeatedCount, maxLoopCount) {
    Map<String, Competencies> competencies =
        UserProgressService.wordCompetencies;

    final exercises = [];
    Random random = Random();
    int loopCount = 0;
    while (exercises.length < count) {
      loopCount++;
      if (loopCount > maxLoopCount) {
        break;
      }

      MapEntry<String, dynamic>? exercise =
          competencies.entries.firstWhereOrNull((element) {
        final exerciseRepeatedCount = exercises.fold<int>(
            0,
            (previousValue, el) =>
                el.key == element.key ? previousValue + 1 : previousValue);
        if (exerciseRepeatedCount >= maxRepeatedCount) return false;
        return random.nextDouble() < element.value.total;
      });

      if (exercise == null) {
        continue;
      }

      exercises.add(exercise);
    }
    exercises.shuffle();
    return exercises;
  }

  static _getOptions(correct, count) {
    Random random = Random();
    Map<String, Competencies> competencies =
        UserProgressService.wordCompetencies;
    final options = <String>[];
    final words = competencies.keys.toList();
    for (int i = 0; i < words.length; i++) {
      if (options.length >= count - 1) break;
      if (words[i].length != correct.length ||
          words[i] == correct ||
          random.nextDouble() < 0.5) continue;

      options.add(words[i]);
    }
    options.add(correct);
    options.shuffle();
    return options;
  }
}
