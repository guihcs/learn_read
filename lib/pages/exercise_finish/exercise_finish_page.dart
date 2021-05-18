import 'package:flutter/material.dart';
import 'package:learn_read/services/audio/audio_service.dart';
import 'package:learn_read/services/exercise/user_progress_service.dart';

class ExerciseFinishPage extends StatefulWidget {
  @override
  _ExerciseFinishPageState createState() => _ExerciseFinishPageState();
}

class _ExerciseFinishPageState extends State<ExerciseFinishPage> {


  @override
  void didChangeDependencies() {
    AudioService.instance.playFile('assets/sounds/level_complete.mp3');
    UserProgressService.saveProgress();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/baloons.png'),
          ),
          ElevatedButton(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.check, size: 48,),
          ), onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
          },)
        ],),

      ),
    );
  }
}
