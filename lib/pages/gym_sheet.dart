import 'package:flutter/material.dart';
import 'package:fit_core_app/pages/food_registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GymSheet extends StatefulWidget {
  @override
  _GymSheetState createState() => _GymSheetState();
}

class _GymSheetState extends State<GymSheet> {
  bool isChecked = false;
  List<Map<String, dynamic>> mondayExercises = [];

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  Future<void> _fetchExercises() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('workout_plan')
          .doc('SQNUCH8pSsegocHs4zqK')
          .collection('weekly_plan')
          .doc('monday')
          .get();

      setState(() {
        final data = snapshot.data();
        if (data != null) {
          mondayExercises = mondayExercises = (data['exercises'] as List)
              .map((e) => e as Map<String, dynamic>)
              .toList();
        }
        print('Exercícios de segunda-feira: $mondayExercises');
      });
    } catch (err) {
      print('Error fetching exercises: $err');
    }
  }

  Future<Map<String, dynamic>> fetchExerciseDetails(DocumentReference exerciseRef) async {
    try {
      final snapshot = await exerciseRef.get();
      final exerciseData = snapshot.data() as Map<String, dynamic>;
      return exerciseData;
    } catch (err) {
      print('Erro ao buscar os dados do exercício: $err');
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Gym Sheet'), actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodRegistration()),
              );
            },
            icon: const Icon(Icons.restaurant),
            tooltip: "Registro de alimentos",
          )
        ]),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 25.0, // Altura do container
                width: 300.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      final days = [
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',
                        'Sunday'
                      ];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                            width: 25.0,
                            height: 25.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Text(
                              days[index][0].toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      );
                    }),
              ),
            ),
            SizedBox(height: 30.0), // Espaçamento entre os elementos
            // Lista de exercícios
      Expanded(
        child: ListView.builder(
          itemCount: mondayExercises.length,
          itemBuilder: (context, index) {
            final exercise = mondayExercises[index];
            return FutureBuilder<Map<String, dynamic>>(
              future: fetchExerciseDetails(exercise['exercise_ref']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Mostra um indicador de carregamento
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar exercício');
                } else if (snapshot.hasData) {
                  final exDetails = snapshot.data!;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: exDetails['name'], // Exibe o nome do exercício
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Peso (kg)',
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (bool? newVal) {
                                print('Opa trocou para: $newVal');
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                    ],
                  );
                } else {
                  return Text('Nenhum dado encontrado');
                }
              },
            );
          },
        ),
      ),
          ],
        ));
  }

// @override
// void dispose() {
//   nameController.dispose();
//   emailController.dispose();
//   super.dispose();
// }
}
