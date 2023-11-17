import 'package:flutter/material.dart';
import 'package:primeiro_app/model/funcionario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EdicaoFuncionariosScreen extends StatefulWidget {
  final Funcionario funcionario;

  EdicaoFuncionariosScreen({required this.funcionario});

  @override
  _EdicaoFuncionariosScreenState createState() => _EdicaoFuncionariosScreenState();
}

class _EdicaoFuncionariosScreenState extends State<EdicaoFuncionariosScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.funcionario.nome;
    _cargoController.text = widget.funcionario.cargo;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cargoController.dispose();
    super.dispose();
  }

  void _atualizarFuncionario() {
    firestore.collection('funcionarios').doc(widget.funcionario.id).update({
      'nome': _nomeController.text,
      'cargo': _cargoController.text,
    }).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Funcionário atualizado com sucesso.')));
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao atualizar funcionário: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Funcionário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _cargoController,
              decoration: InputDecoration(labelText: 'Cargo'),
            ),
            ElevatedButton(
              child: Text('Salvar Alterações'),
              onPressed: _atualizarFuncionario,
            ),
          ],
        ),
      ),
    );
  }
}
