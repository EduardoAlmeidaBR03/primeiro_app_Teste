import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primeiro_app/model/funcionario.dart'; // Certifique-se de criar o arquivo funcionario.dart com a classe Funcionario
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class CadastroFuncionarioScreen extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cargoController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Funcionário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome do Funcionário'),
            ),
            TextField(
              controller: cargoController,
              decoration: InputDecoration(labelText: 'Cargo do Funcionário'),
            ),
            ElevatedButton(
              child: Text('Salvar Funcionário'),
              onPressed: () {
                final String nome = nomeController.text;
                final String cargo = cargoController.text;
                if (nome.isNotEmpty && cargo.isNotEmpty) {
                  salvarFuncionario(nome, cargo, context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void salvarFuncionario(String nome, String cargo, BuildContext context) {
    final Funcionario novoFuncionario = Funcionario(id: '', nome: nome, cargo: cargo);
    firestore.collection('funcionarios').add(novoFuncionario.toMap()).then((_) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Funcionário salvo com sucesso.')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar funcionário: $error')));
    });
  }
}
