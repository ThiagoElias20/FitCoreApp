import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fit_core_app/database_helper.dart';


class FoodRegistration extends StatefulWidget {

  @override
  _FoodRegistrationState createState() => _FoodRegistrationState();
}

class _FoodRegistrationState extends State<FoodRegistration> {
  File? _selectedImage;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _caloriasController = TextEditingController();
  final TextEditingController _porcaoController = TextEditingController();
  final TextEditingController _proteinasController = TextEditingController();
  final TextEditingController _carboidratosController = TextEditingController();
  final TextEditingController _gordurasController = TextEditingController();

  void _salvarAlimento() async {
    final nome = _nomeController.text;
    final calorias = double.tryParse(_caloriasController.text) ?? 0.0;
    final porcao = _porcaoController.text;
    final proteinas = double.tryParse(_proteinasController.text) ?? 0.0;
    final carboidratos = double.tryParse(_carboidratosController.text) ?? 0.0;
    final gorduras = double.tryParse(_gordurasController.text) ?? 0.0;
    final imagem = _selectedImage?.path ?? "";

    if (nome.isNotEmpty && calorias > 0) {
      final alimento = {
        'nome': nome,
        'calorias': calorias,
        'porcao': porcao,
        'proteinas': proteinas,
        'carboidratos': carboidratos,
        'gorduras': gorduras,
        'imagem': imagem,
      };

      await DatabaseHelper().inserirAlimento(alimento);

      // Exibir os dados no console
      await DatabaseHelper().listarAlimentosNoConsole();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Alimento registrado com sucesso!')),
      );

      // reseta os campos
      _nomeController.clear();
      _caloriasController.clear();
      _porcaoController.clear();
      _proteinasController.clear();
      _carboidratosController.clear();
      _gordurasController.clear();
      setState(() {
        _selectedImage = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos corretamente!')),
      );
    }
  }

  // seleciona imagem da galeria
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Food Registration'),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _selectedImage != null
                      ? Image.file(_selectedImage!, width: 100, height: 100, fit: BoxFit.cover)
                      : Text("Nenhuma imagem selecionada"),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text("Selecionar Imagem"),
                  ),
                ],
              ),
            ),
            Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _caloriasController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Calorias (kcal)',
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _porcaoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Porção (g)'),),
                  ),
                  Container(
                    width: 300,
                    child: Column(
                      children: [
                        Text('Macronutrientes'),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: _proteinasController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Proteínas (g)',
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: _carboidratosController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Carboidratos (g)',
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: _gordurasController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Gorduras (g)',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Container(
                      width: 200,
                      child: ElevatedButton(onPressed: _salvarAlimento, child: Text('Registrar Alimento'),)),
                )
              ],
            ),
          ],
        ),
    );
  }
}