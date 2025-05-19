import 'package:flutter/material.dart';

class WorkoutCreator extends StatefulWidget {
  @override
  _WorkoutCreatorState createState() => _WorkoutCreatorState();
}

class _WorkoutCreatorState extends State<WorkoutCreator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Creator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Exercise Name',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your action here
              },
              child: Text('Add Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}