import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> adicionarCarro(String modelo, String marca, String cor, String placa) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('carros').add({
      'modelo': modelo,
      'marca': marca,
      'cor': cor,
      'placa': placa,
    });
  } catch (e) {
    print('Erro ao adicionar carro: $e');
    throw e;
  }
}

class CadastroCarrosScreen extends StatelessWidget {
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController corController = TextEditingController(); 
  final TextEditingController placaController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Carro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: modeloController,
              decoration: InputDecoration(labelText: 'Modelo do Carro'),
            ),
            TextField(
              controller: marcaController,
              decoration: InputDecoration(labelText: 'Marca do Carro'),
            ),
            TextField(
              controller: corController,
              decoration: InputDecoration(labelText: 'Cor do Carro'), 
            ),
            TextField(
              controller: placaController,
              decoration: InputDecoration(labelText: 'Placa do Carro'), 
            ),
            ElevatedButton(
              child: Text('Salvar Carro'),
              onPressed: () async {
                final String modelo = modeloController.text;
                final String marca = marcaController.text;
                final String cor = corController.text; // Obtendo a cor inserida
                final String placa = placaController.text; // Obtendo a placa inserida
                if (modelo.isNotEmpty && marca.isNotEmpty && cor.isNotEmpty && placa.isNotEmpty) {
                  try {
                    await adicionarCarro(modelo, marca, cor, placa); // Passando cor e placa para a função adicionarCarro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Carro salvo com sucesso!')),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao salvar Carro: $e')),
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
