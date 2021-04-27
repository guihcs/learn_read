


import 'package:flutter/material.dart';
import 'package:learn_read/services/audio/audio_service.dart';

class ExerciseFinishPage extends StatefulWidget {
  @override
  _ExerciseFinishPageState createState() => _ExerciseFinishPageState();
}

class _ExerciseFinishPageState extends State<ExerciseFinishPage> {

  @override
  void didChangeDependencies() {
    AudioService.instance.playFile('assets/sounds/level_complete.mp3');

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Image.asset('assets/images/baloons.png'),
          ElevatedButton(child: Icon(Icons.check), onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
          },)
        ],),
      ),
    );
  }
}