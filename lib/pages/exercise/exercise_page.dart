import 'package:flutter/material.dart';
import 'package:learn_read/models/exercise/exercise_config.dart';
import 'package:learn_read/services/audio/audio_service.dart';
import 'package:learn_read/services/exercise/exercise_generator.dart';
import 'package:learn_read/services/exercise/exercise_service.dart';
import 'package:learn_read/widgets/confirm_buttom.dart';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>
    with SingleTickerProviderStateMixin {
  bool _isChanging = false;
  int _currentExerciseIndex = 0;
  late List<ExerciseConfig> _exercises;

  late ExerciseConfig _currentExercise;
  late ExerciseConfig _nextExercise;

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      if (_pageController.page == 1) {
        if (_currentExerciseIndex < _exercises.length)
          _currentExercise = _exercises[_currentExerciseIndex];
        if (_currentExerciseIndex < _exercises.length - 1)
          _nextExercise = _exercises[_currentExerciseIndex + 1];
        _currentExercise.visible = true;
        _pageController.jumpToPage(0);
        setState(() {
          _isChanging = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    _exercises =
        ModalRoute.of(context)!.settings.arguments as List<ExerciseConfig>;
    _exercises.forEach((element) {
      element.onChanged = (value) {
        setState(() {
          _exercises[_currentExerciseIndex].currentSelected = value;
        });
      };
    });

    if (_currentExerciseIndex < _exercises.length)
      _currentExercise = _exercises[_currentExerciseIndex];
    if (_currentExerciseIndex < _exercises.length - 1)
      _nextExercise = _exercises[_currentExerciseIndex + 1];

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [_progressTile(), _exerciseArea(), _confirmButton()],
          ),
        ),
      ),
    );
  }

  _progressTile() {
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: LinearProgressIndicator(
          minHeight: 10,
          value: _currentExerciseIndex / _exercises.length,
        ),
      ),
    );
  }

  _exerciseArea() {
    return Expanded(
        child: PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        ExerciseBuilder.build(_currentExercise, visible: true),
        ExerciseBuilder.build(_nextExercise),
      ],
    ));
  }

  _confirmButton() {
    ExerciseConfig config = _exercises[_currentExerciseIndex];

    return ListTile(
        title: ConfirmButton(
      isCorrect: config.responded ? config.isCorrect() : null,
      enabled: config.currentSelected != null,
      onClick: () {
        if (config.isCorrect() == null) return;
        if (config.isCorrect()!) {
          AudioService.instance
              .playFile('assets/sounds/correct2.mp3', volume: 0.3);
        } else if (!config.isCorrect()!) {
          AudioService.instance
              .playFile('assets/sounds/wrong.wav', volume: 0.5);
        }
        _answerQuestion(config);
      },
      onAnimationEnd: () {
        _onButtonAnimationEnd(config);
      },
    ));
  }

  _answerQuestion(config) {
    ExerciseGenerator.answerQuestion(config);
    setState(() {});
  }

  _onButtonAnimationEnd(config) {
    if (!((config.isCorrect() ?? false) && !_isChanging)) {
      config.responded = false;
      return;
    }

    if (_currentExerciseIndex + 1 >= _exercises.length) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('exerciseFinish', (route) => false);
    } else {
      _loadNextExercise();
    }
  }

  _loadNextExercise() {
    _isChanging = true;
    _pageController.animateToPage(1,
        duration: Duration(milliseconds: 600), curve: Curves.ease);

    setState(() {
      _currentExerciseIndex++;
    });
  }
}
