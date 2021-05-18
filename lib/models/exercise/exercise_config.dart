
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

  ExerciseConfig({required this.name, required this.correctOption, this.currentSelected, this.options = const [], this.onChanged});

  @override
  String toString() {
    return 'ExerciseConfig{type: $name, correct: $correctOption, options: $options }';
  }


  bool? isCorrect() => currentSelected != null ? currentSelected == correctOption : null;
}