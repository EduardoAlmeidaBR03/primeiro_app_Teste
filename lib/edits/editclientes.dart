
import 'package:flutter/material.dart';
import 'package:primeiro_app/model/clientes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EdicaoClienteScreen extends StatefulWidget {
  final Clientes cliente;

  EdicaoClienteScreen({required this.cliente});

  @override
  _EdicaoClienteScreenState createState() => _EdicaoClienteScreenState();
}

class _EdicaoClienteScreenState extends State<EdicaoClienteScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.cliente.nome;
    _cpfController.text = widget.cliente.cpf;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  void _atualizarCliente() {
    firestore.collection('clientes').doc(widget.cliente.id).update({
      'nome': _nomeController.text,
      'cpf': _cpfController.text,
    }).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cliente atualizado com sucesso.')));
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao atualizar cliente: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente'),
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
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            ElevatedButton(
              child: Text('Salvar Alterações'),
              onPressed: _atualizarCliente,
            ),
          ],
        ),
      ),
    );
  }
}