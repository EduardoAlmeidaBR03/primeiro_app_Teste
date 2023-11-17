// lib/cadastro_cliente_screen.dart
import 'package:flutter/material.dart';
import 'package:primeiro_app/model/clientes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Future<void> adicionarCliente(String nome, String cpf) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('clientes').add({
      'nome': nome,
      'cpf': cpf,
    });
  } catch (e) {
    print('Erro ao adicionar cliente: $e');
    throw e;  
  }
}

class CadastroClienteScreen extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;  // Instância do Firestore

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome do Cliente'),
            ),
            TextField(
              controller: cpfController,
              decoration: InputDecoration(labelText: 'CPF do Cliente'),
            ),
            ElevatedButton(
              child: Text('Salvar Cliente'),
              onPressed: () async {
                final String nome = nomeController.text;
                final String cpf = cpfController.text;
                if (nome.isNotEmpty && cpf.isNotEmpty) {
                  try {
                    await adicionarCliente(nome, cpf);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cliente salvo com sucesso!')),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao salvar cliente: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, preencha todos os campos')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}