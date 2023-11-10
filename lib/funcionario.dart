import 'package:flutter/material.dart';

class Funcionario {
  String nome;
  int cpf;
  int numeroTelefone;
  Funcionario({required this.nome, required this.cpf, required this.numeroTelefone});
}

class CadastroFuncionario extends StatefulWidget {
  @override
  _CadastroFuncionarioState createState() => _CadastroFuncionarioState();
}

class _CadastroFuncionarioState extends State<CadastroFuncionario> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  List<Funcionario> listaFuncionarios = [];

  void cadastrarFuncionario() {
    String nome = nomeController.text;
    int cpf = int.parse(cpfController.text);
    int telefone = int.parse(telefoneController.text);

    Funcionario novoFuncionario = Funcionario(nome: nome, cpf: cpf, numeroTelefone: telefone);

    listaFuncionarios.add(novoFuncionario);

    nomeController.clear();
    cpfController.clear();
    telefoneController.clear();
  }

  void listarFuncionarios() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Funcionários Cadastrados'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: listaFuncionarios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listaFuncionarios[index].nome),
                  subtitle: Text('CPF: ${listaFuncionarios[index].cpf}'),
                  trailing: Text('Telefone: ${listaFuncionarios[index].numeroTelefone}'),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
        title: Text('Cadastro de Funcionário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
              controller: cpfController,
              decoration: InputDecoration(
                labelText: 'CPF',
              ),
            ),
            TextField(
              controller: telefoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
              ),
            ),
            ElevatedButton(
              onPressed: cadastrarFuncionario,
              child: Text('Cadastrar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: listarFuncionarios,
              child: Text('Listar'),
            ),
          ],
        ),
      ),
    );
  }
}
