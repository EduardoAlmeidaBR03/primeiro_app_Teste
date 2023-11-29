import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primeiro_app/crud/cadastro_funcionario_screen.dart';

class CadastroOrdemServicoScreen extends StatefulWidget {
  @override
  _CadastroOrdemServicoScreenState createState() => _CadastroOrdemServicoScreenState();
}

class _CadastroOrdemServicoScreenState extends State<CadastroOrdemServicoScreen> {
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController carroController = TextEditingController();
  final TextEditingController funcionarioController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  String? selectedFuncionarioId;
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
            StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('funcionarios').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                List<DropdownMenuItem<String>> funcionarioItems = snapshot.data!.docs
                    .map((doc) => DropdownMenuItem<String>(
                          child: Text(doc['nome']),
                          value: doc.id,
                        ))
                    .toList();
                return Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedFuncionarioId,
                        hint: Text('Selecione um Funcionário'),
                        onChanged: (value) {
                          setState(() {
                            selectedFuncionarioId = value;
                          });
                        },
                        items: funcionarioItems,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CadastroFuncionarioScreen()),
                        );
                      },
                    ),
                  ],
                );
              },
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
                  salvarOrdemServico(cliente, carro, funcionario, placa, context);
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
