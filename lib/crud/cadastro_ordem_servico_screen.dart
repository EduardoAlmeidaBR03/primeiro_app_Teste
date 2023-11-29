import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroOrdemServicoScreen extends StatelessWidget {
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController carroController = TextEditingController();
  final TextEditingController funcionarioController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Ordem de Serviço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: clienteController,
              decoration: InputDecoration(labelText: 'Cliente'),
            ),
            TextField(
              controller: carroController,
              decoration: InputDecoration(labelText: 'Carro'),
            ),
            TextField(
              controller: funcionarioController,
              decoration: InputDecoration(labelText: 'Funcionário'),
            ),
            TextField(
              controller: placaController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            ElevatedButton(
              child: Text('Salvar Ordem de Serviço'),
              onPressed: () {
                final String cliente = clienteController.text;
                final String carro = carroController.text;
                final String funcionario = funcionarioController.text;
                final String placa = placaController.text;
                if (cliente.isNotEmpty && carro.isNotEmpty && funcionario.isNotEmpty && placa.isNotEmpty) {
                  salvarOrdemServico(cliente, carro, funcionario, placa,  context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void salvarOrdemServico(String cliente, String carro, String funcionario, String placa, BuildContext context) {
    Map<String, dynamic> novaOrdemServico = {
      'cliente': cliente,
      'carro': carro,
      'funcionario': funcionario,
      'placa': placa,
    };
    firestore.collection('ordens_servico').add(novaOrdemServico).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ordem de serviço salva com sucesso.')));
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar ordem de serviço: $error')));
    });
  }
}
