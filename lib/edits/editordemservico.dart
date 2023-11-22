import 'package:flutter/material.dart';
import 'package:primeiro_app/model/ordem_servico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  void initState() {
    super.initState();
    _clienteController.text = widget.ordemServico.cliente;
    _carroController.text = widget.ordemServico.carro;
    _funcionarioController.text = widget.ordemServico.funcionario;
  }

  @override
  void dispose() {
    _clienteController.dispose();
    _carroController.dispose();
    _funcionarioController.dispose();
    super.dispose();
  }

  void _atualizarOrdemServico() {
    firestore.collection('ordens_servico').doc(widget.ordemServico.id).update({
      'cliente': _clienteController.text,
      'carro': _carroController.text,
      'funcionario': _funcionarioController.text,
      // Adicione aqui a lógica para atualizar outras informações da ordem de serviço
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
            TextField(
              controller: _funcionarioController,
              decoration: InputDecoration(labelText: 'Funcionário'),
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
