class ExerciseTypes {
  static const findFromSpeak = 'findFromSpeak';
  static const readWord = 'readWord';
  static const all = ['findFromSpeak', 'readWord'];
}

class ExerciseConfig {
  String name;
  String correctOption;
  String? currentSelected;
  List<String> options;
  Function(String)? onChanged;
  bool responded = false;
  DateTime generationTime;
  bool visible;

  ExerciseConfig(
      {required this.name,
      required this.correctOption,
      required this.visible,
      this.currentSelected,
      this.options = const [],
      this.onChanged,
      required this.generationTime});

  @override
  String toString() {
    return 'ExerciseConfig{type: $name, correct: $correctOption, options: $options }';
  }

  bool? isCorrect() => currentSelected != null ? currentSelected == correctOption : null;
}
