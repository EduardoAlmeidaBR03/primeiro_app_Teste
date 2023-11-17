import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> adicionarCarro(String modelo, String marca) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('carros').add({
      'modelo': modelo,
      'marca': marca,
    });
  } catch (e) {
    print('Erro ao adicionar carro: $e');
    throw e;
  }
}

class CadastroCarrosScreen extends StatelessWidget {
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();

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
            ElevatedButton(
              child: Text('Salvar Carro'),
              onPressed: () async {
                final String modelo = modeloController.text;
                final String marca = marcaController.text;
                if (modelo.isNotEmpty && marca.isNotEmpty) {
                  try {
                    await adicionarCarro(modelo, marca);
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
