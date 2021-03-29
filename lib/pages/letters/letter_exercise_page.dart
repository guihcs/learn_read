import 'package:flutter/material.dart';
import 'package:learn_read/services/exercise/exercise_service.dart';
import 'package:learn_read/widgets/confirm_buttom.dart';

class LetterExercisePage extends StatefulWidget {
  @override
  _LetterExercisePageState createState() => _LetterExercisePageState();
}

class _LetterExercisePageState extends State<LetterExercisePage>
    with SingleTickerProviderStateMixin {
  dynamic _currentSelected;
  dynamic _correct = 'A';
  bool? _isCorrect;
  bool _isChanging = false;

  late String _currentExercise;
  late String _nextExercise;

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentExercise = 'findFromSpeak';
    _nextExercise = 'findFromSpeak';

    _pageController.addListener(() {
      if (_pageController.page == 1) {
        setState(() {
          _currentExercise = _nextExercise;
          _nextExercise = 'findFromSpeak';
          _pageController.jumpToPage(0);
          _isCorrect = null;
          _isChanging = false;
          _currentSelected = null;
        });
      }
    });
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
            children: [
              _progressTile(),
              Expanded(
                  child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  ExerciseBuilder.build(
                    ExerciseConfig(
                        name: _currentExercise,
                        correctOption: 'A',
                        currentSelected: _currentSelected,
                        options: ['A', 'E', 'I', 'O'],
                        onChanged: (value) {
                          setState(() {
                            _currentSelected = value;
                          });
                        }),
                  ),
                  ExerciseBuilder.build(ExerciseConfig(
                      name: _nextExercise,
                      correctOption: 'A',
                      currentSelected: _currentSelected,
                      options: ['A', 'E', 'I', 'O'],
                      onChanged: (value) {
                        setState(() {
                          _currentSelected = value;
                        });
                      })),
                ],
              )),
              _confirmButton()
            ],
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
          value: 0.5,
        ),
      ),
    );
  }

  _confirmButton() {
    return ListTile(
        title: ConfirmButton(
      isCorrect: _isCorrect,
      enabled: _currentSelected != null,
      onClick: () {
        setState(() {
          _isCorrect =
              _currentSelected == null ? null : _correct == _currentSelected;

          if ((_isCorrect ?? false) && !_isChanging) {
            _isChanging = true;

            Future.delayed(Duration(seconds: 1), () {
              _pageController.animateToPage(1,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                if (!mounted) return;
                setState(() {
                  _currentSelected = null;
                });
              });
            });
          }
        });
      },
    ));
  }
}
