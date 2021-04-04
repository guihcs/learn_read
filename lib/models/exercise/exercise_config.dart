
class ExerciseTypes {
  static const findFromSpeak = 'findFromSpeak';
}


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

  @override
  String toString() {
    return 'ExerciseConfig{type: $name, correct: $correctOption, options: $options }';
  }
}