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
  final TextEditingController placaController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  String? selectedFuncionarioNome;
  String? selectedSituacao; // Adicione esta linha para armazenar a situação selecionada
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
                          value: doc['nome'],
                        ))
                    .toList();
                return Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedFuncionarioNome,
                        hint: Text('Selecione um Funcionário'),
                        onChanged: (value) {
                          setState(() {
                            selectedFuncionarioNome = value;
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
            if (selectedFuncionarioNome != null)
              Text(
                'Funcionário: ${selectedFuncionarioNome}',
                style: TextStyle(fontSize: 16),
              ),
            TextField(
              controller: placaController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: valorController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number, 
            ),


            ElevatedButton(
              child: Text('Salvar Ordem de Serviço'),
              onPressed: () {
                final String cliente = clienteController.text;
                final String carro = carroController.text;
                final String funcionario = selectedFuncionarioNome ?? '';
                final String placa = placaController.text;
                final String descricao = descricaoController.text;
                final double valor = double.parse(valorController.text);
                final String situacao = selectedSituacao ?? 'Aberta'; // Adicione a situação ao mapa

                if (cliente.isNotEmpty && carro.isNotEmpty && funcionario.isNotEmpty && placa.isNotEmpty && descricao.isNotEmpty && valor > 0) {
                  salvarOrdemServico(cliente, carro, funcionario, placa, descricao, valor, situacao, context); // Passe a situação para o método salvarOrdemServico
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

  void salvarOrdemServico(String cliente, String carro, String funcionario, String placa, String descricao, double valor, String situacao, BuildContext context) {
    DateTime dataCriacao = DateTime.now(); // Adiciona a data de criação atual
    Map<String, dynamic> novaOrdemServico = {
      'cliente': cliente,
      'carro': carro,
      'funcionario': funcionario,
      'placa': placa,
      'descricao': descricao,
      'valor': valor,
      'situacao': situacao,
      'dataCriacao': dataCriacao, // Adiciona a data de criação ao mapa
    };
    firestore.collection('ordens_servico').add(novaOrdemServico).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ordem de serviço salva com sucesso.')));
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar ordem de serviço: $error')));
    });
  }
}
