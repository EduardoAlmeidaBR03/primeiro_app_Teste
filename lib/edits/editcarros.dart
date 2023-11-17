import 'package:flutter/material.dart';
import 'package:primeiro_app/model/carros.dart'; // Supondo que você tenha uma classe Carros
import 'package:cloud_firestore/cloud_firestore.dart';

class EdicaoCarrosScreen extends StatefulWidget {
  final Carros carro;

  EdicaoCarrosScreen({required this.carro});

  @override
  _EdicaoCarrosScreenState createState() => _EdicaoCarrosScreenState();
}

class _EdicaoCarrosScreenState extends State<EdicaoCarrosScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _modeloController.text = widget.carro.modelo;
    _marcaController.text = widget.carro.marca;
  }

  @override
  void dispose() {
    _modeloController.dispose();
    _marcaController.dispose();
    super.dispose();
  }

  void _atualizarCarro() {
    firestore.collection('carros').doc(widget.carro.id).update({
      'modelo': _modeloController.text,
      'marca': _marcaController.text,
    }).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Carro atualizado com sucesso.')));
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao atualizar carro: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Carro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: _marcaController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            ElevatedButton(
              child: Text('Salvar Alterações'),
              onPressed: _atualizarCarro,
            ),
          ],
        ),
      ),
    );
  }
}
