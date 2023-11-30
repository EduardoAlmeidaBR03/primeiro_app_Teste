import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primeiro_app/model/funcionario.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart'; // Importe esta biblioteca

FirebaseDatabase database = FirebaseDatabase.instance;

class CadastroFuncionarioScreen extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cargoController = TextEditingController();
  final TextEditingController contatoController = TextEditingController();
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
            TextField(
              controller: contatoController,
              decoration: InputDecoration(labelText: 'Contato do Funcionário'),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              child: Text('Salvar Funcionário'),
              onPressed: () {
                final String nome = nomeController.text;
                final String cargo = cargoController.text;
                final String contato = contatoController.text;
                if (nome.isNotEmpty && cargo.isNotEmpty && contato.isNotEmpty) {
                  salvarFuncionario(nome, cargo, contato, context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void salvarFuncionario(String nome, String cargo, String contato, BuildContext context) {
    final Funcionario novoFuncionario = Funcionario(id: '', nome: nome, cargo: cargo, contato: contato);
    firestore.collection('funcionarios').add(novoFuncionario.toMap()).then((_) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Funcionário salvo com sucesso.')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar funcionário: $error')));
    });
  }
}
