import 'package:flutter/material.dart';

class Carro {
  String modelo;
  String placa;
  String cor;
  Carro({required this.modelo, required this.placa, required this.cor});
}

class CadastroCarro extends StatefulWidget {
  @override
  _CadastroCarroState createState() => _CadastroCarroState();
}

class _CadastroCarroState extends State<CadastroCarro> {
  TextEditingController modeloController = TextEditingController();
  TextEditingController placaController = TextEditingController();
  TextEditingController corController = TextEditingController();

  List<Carro> carros = [];

  void cadastrarCarro() {
    String modelo = modeloController.text;
    String placa = placaController.text;
    String cor = corController.text;

    Carro novoCarro = Carro(modelo: modelo, placa: placa, cor: cor);

    setState(() {
      carros.add(novoCarro);
    });

    modeloController.clear();
    placaController.clear();
    corController.clear();
  }

  void listarCarros() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Carros Cadastrados'),
          content: Column(
            children: carros.map((carro) => Text('${carro.modelo} - ${carro.placa}')).toList(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Carro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: modeloController,
              decoration: InputDecoration(
                labelText: 'Modelo',
              ),
            ),
            TextField(
              controller: placaController,
              decoration: InputDecoration(
                labelText: 'Placa',
              ),
            ),
            TextField(
              controller: corController,
              decoration: InputDecoration(
                labelText: 'Cor',
              ),
            ),
            ElevatedButton(
              onPressed: cadastrarCarro,
              child: Text('Cadastrar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: listarCarros,
              child: Text('Listar'),
            ),
          ],
        ),
      ),
    );
  }
}
