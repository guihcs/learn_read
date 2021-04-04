


import 'package:flutter/material.dart';

class ExerciseFinishPage extends StatefulWidget {
  @override
  _ExerciseFinishPageState createState() => _ExerciseFinishPageState();
}

class _ExerciseFinishPageState extends State<ExerciseFinishPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Text('Exercise finish'),
          ElevatedButton(child: Icon(Icons.check), onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
          },)
        ],),
      ),
    );
  }
}