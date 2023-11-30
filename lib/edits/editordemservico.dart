import 'package:flutter/material.dart';
import 'package:primeiro_app/model/ordem_servico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primeiro_app/crud/cadastro_funcionario_screen.dart';

class EdicaoOrdemServicoScreen extends StatefulWidget {
  final OrdemServico ordemServico;

  EdicaoOrdemServicoScreen({required this.ordemServico});

  @override
  _EdicaoOrdemServicoScreenState createState() => _EdicaoOrdemServicoScreenState();
}

class _EdicaoOrdemServicoScreenState extends State<EdicaoOrdemServicoScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _carroController = TextEditingController();
  final TextEditingController _funcionarioController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  String? selectedFuncionarioNome;

  @override
  void initState() {
    super.initState();
    _clienteController.text = widget.ordemServico.cliente;
    _carroController.text = widget.ordemServico.carro;
    _funcionarioController.text = widget.ordemServico.funcionario;
    _descricaoController.text = widget.ordemServico.descricao;
    _valorController.text = widget.ordemServico.valor.toString();
  }

  void _atualizarOrdemServico() {
    firestore.collection('ordens_servico').doc(widget.ordemServico.id).update({
      'cliente': _clienteController.text,
      'carro': _carroController.text,
      'funcionario': _funcionarioController.text,
      'descricao': _descricaoController.text,
      'valor': double.parse(_valorController.text),
    }).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ordem de serviço atualizada com sucesso.')));
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao atualizar ordem de serviço: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Ordem de Serviço'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _clienteController,
              decoration: InputDecoration(labelText: 'Cliente'),
            ),
            TextField(
              controller: _carroController,
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
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number, // Adiciona o teclado numérico
            ),
            ElevatedButton(
              child: Text('Salvar Alterações'),
              onPressed: _atualizarOrdemServico,
            ),
          ],
        ),
      ),
    );
  }
}
