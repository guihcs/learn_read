import 'package:flutter/material.dart';
import 'package:learn_read/pages/exercise_finish/exercise_finish_page.dart';
import 'package:learn_read/pages/home.dart';
import 'package:learn_read/pages/reading/text_choose.dart';
import 'package:learn_read/pages/reading/text_read.dart';
import 'package:learn_read/services/exercise/user_progress_service.dart';

import 'pages/exercise/exercise_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserProgressService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'exercise': (context) => ExercisePage(),
        'exerciseFinish': (context) => ExerciseFinishPage(),
        'textChoose': (context) => TextChoosePage(),
        'textRead': (context) => TextReadPage()
      },
    );
  }
}

