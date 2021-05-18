import 'package:flutter/material.dart';
import 'package:learn_read/services/exercise/exercise_generator.dart';

class ExercisesTab extends StatefulWidget {
  @override
  _ExercisesTabState createState() => _ExercisesTabState();
}

class _ExercisesTabState extends State<ExercisesTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      child: Column(
        children: [_wordExercise(), _textReading()],
      ),
    );
  }

  _wordExercise() {
    return InkWell(
      onTap: () {
        final exercises = ExerciseGenerator.generate(10, 3);
        Navigator.of(context).pushNamed('exercise', arguments: exercises);
      },
      child: _activityTile(Icons.fitness_center)
    );
  }

  _textReading() {
    return InkWell(
      onTap: () {
        final exercises = ExerciseGenerator.generate(10, 3);
        Navigator.of(context).pushNamed('textChoose', arguments: exercises);
      },
      child: _activityTile(Icons.book)
    );
  }


  _activityTile(icon){
    return Card(
      child: Container(
          padding: EdgeInsets.all(64),
          child: Icon(
            icon,
            size: 52,
            color: Colors.deepPurple[800],
          )),
    );
  }
}
