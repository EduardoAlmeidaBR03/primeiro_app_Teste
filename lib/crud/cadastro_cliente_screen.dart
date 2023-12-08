import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Future<void> adicionarCliente(String nome, String cpf, String contato, String endereco) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('clientes').add({
      'nome': nome,
      'cpf': cpf,
      'contato': contato,
      'endereco': endereco,
    });
  } catch (e) {
    print('Erro ao adicionar cliente: $e');
    throw e;  
  }
}

class CadastroClienteScreen extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController contatoController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;  

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
            TextField(
              controller: contatoController,
              decoration: InputDecoration(labelText: 'Contato'),
            ),
            TextField(
              controller: enderecoController,
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            ElevatedButton(
              child: Text('Salvar Cliente'),
              onPressed: () async {
                final String nome = nomeController.text;
                final String cpf = cpfController.text;
                final String contato = contatoController.text;
                final String endereco = enderecoController.text;
                if (nome.isNotEmpty && cpf.isNotEmpty && contato.isNotEmpty && endereco.isNotEmpty) {
                  if (validarCPF(cpf)) {
                    try {
                      await adicionarCliente(nome, cpf, contato, endereco);
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
                      SnackBar(content: Text('CPF inválido. Por favor, insira um CPF válido')),
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


bool validarCPF(String cpf) {
  if (cpf.isEmpty) {
    return false; 
  }

  // Remover caracteres não numéricos do CPF
  cpf = cpf.replaceAll(RegExp(r'\D'), '');

  if (cpf.length != 11) {
    return false; // CPF com tamanho incorreto
  }


  if (RegExp(r'(\d)\1{10}').hasMatch(cpf)) {
    return false; // CPF com todos os dígitos iguais
  }

  // Calcular o primeiro dígito verificador
  var soma = 0;
  for (var i = 0; i < 9; i++) {
    soma += int.parse(cpf[i]) * (10 - i);
  }
  var digito1 = 11 - (soma % 11);
  if (digito1 > 9) {
    digito1 = 0;
  }

  // Calcular o segundo dígito verificador
  soma = 0;
  for (var i = 0; i < 10; i++) {
    soma += int.parse(cpf[i]) * (11 - i);
  }
  var digito2 = 11 - (soma % 11);
  if (digito2 > 9) {
    digito2 = 0;
  }

  // Verificar se os dígitos verificadores estão corretos
  if (int.parse(cpf[9]) != digito1 || int.parse(cpf[10]) != digito2) {
    return false; // CPF inválido
  }

  return true; 
}
