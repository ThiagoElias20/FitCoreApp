import 'package:flutter/material.dart';
import 'package:fit_core_app/pages/food_registration.dart';
import 'package:fit_core_app/pages/food_list.dart';
import 'package:fit_core_app/pages/workout_creator.dart';
import 'package:fit_core_app/pages/gym_sheet.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GymSheet()),
                      );
                    },
                    child: Text('Gym Sheet'),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WorkoutCreator()),
                      );
                    },
                    child: Text('Workout Creator'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodList()),
                      );
                    },
                    child: Text('Food List'),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodRegistration()),
                      );
                    },
                    child: Text('Food Registration'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}