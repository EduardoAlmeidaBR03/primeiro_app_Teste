import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class CadastroOrdemServicoScreen extends StatelessWidget {
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController carroController = TextEditingController();
  final TextEditingController funcionarioController = TextEditingController();
  final TextEditingController dataInicioController = TextEditingController();
  final TextEditingController dataEntregaController = TextEditingController();
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
              controller: dataInicioController,
              decoration: InputDecoration(labelText: 'Data de Início'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    DateTime selectedDate = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                    dataInicioController.text = selectedDate.toString();
                  }
                }
              },
            ),
            TextField(
              controller: dataEntregaController,
              decoration: InputDecoration(labelText: 'Data de Entrega'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    DateTime selectedDate = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                    dataEntregaController.text = selectedDate.toString();
                  }
                }
              },
            ),
            ElevatedButton(
              child: Text('Salvar Ordem de Serviço'),
              onPressed: () {
                final String cliente = clienteController.text;
                final String carro = carroController.text;
                final String funcionario = funcionarioController.text;
                final String dataInicio = dataInicioController.text;
                final String dataEntrega = dataEntregaController.text;
                if (cliente.isNotEmpty && carro.isNotEmpty && funcionario.isNotEmpty && dataInicio.isNotEmpty && dataEntrega.isNotEmpty) {
                  salvarOrdemServico(cliente, carro, funcionario, dataInicio, dataEntrega, context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void salvarOrdemServico(String cliente, String carro, String funcionario, String dataInicio, String dataEntrega, BuildContext context) {
    final Map<String, dynamic> novaOrdemServico = {
      'cliente': cliente,
      'carro': carro,
      'funcionario': funcionario,
      'dataInicio': dataInicio,
      'dataEntrega': dataEntrega,
      // Adicione aqui a lógica para salvar outras informações da ordem de serviço
    };
    firestore.collection('ordens_servico').add(novaOrdemServico).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ordem de serviço salva com sucesso.')));
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar ordem de serviço: $error')));
    });
  }
}
