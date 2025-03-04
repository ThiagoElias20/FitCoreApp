import 'package:flutter/material.dart';
import 'package:fit_core_app/pages/food_registration.dart';

class GymSheet extends StatefulWidget {
  @override
  _GymSheetState createState() => _GymSheetState();
}

class _GymSheetState extends State<GymSheet> {
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  bool isChecked = false;

//   void handleSubmit() {
//     String name = nameController.text;
//     String email = emailController.text;
//     String checkboxStatus = isChecked ? "Checked" : "Unchecked";
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Form Submitted"),
//         content: Text("Name: $name\nEmail: $email\nCheckbox: $checkboxStatus"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
// }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Centraliza horizontalmente
          crossAxisAlignment: CrossAxisAlignment.center,
          // Centraliza verticalmente
          children: [
            Container(
              width: 150,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Exercício',
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
      ),
    );
  }

// @override
// void dispose() {
//   nameController.dispose();
//   emailController.dispose();
//   super.dispose();
// }
}
