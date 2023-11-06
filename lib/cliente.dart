import 'package:flutter/material.dart';
//import 'package:lava_jato_dart/carro.dart';

class Cliente {
 //impletar para que a class carro esteja contida em cliente e que seja um campo selecionável
  String nome;
  int cpf;
  int numeroTelefone;
  String bairro;
  String rua;
  String cidade;
  Cliente({required this.nome, required this.cpf, required this.numeroTelefone, required this.bairro, required this.rua, required this.cidade});
}

class CadastroCliente extends StatefulWidget {
  @override
  _CadastroClienteState createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  List<Cliente> listaClientes = [];

  void cadastrarCliente() {
    String nome = nomeController.text;
    int cpf = int.parse(cpfController.text);
    int telefone = int.parse(telefoneController.text);
    String bairro = bairroController.text;
    String rua = ruaController.text;
    String cidade = cidadeController.text;

    Cliente novoCliente = Cliente(nome: nome, cpf: cpf, numeroTelefone: telefone, bairro: bairro, rua: rua, cidade: cidade);

    listaClientes.add(novoCliente);

    nomeController.clear();
    cpfController.clear();
    telefoneController.clear();
    bairroController.clear();
    ruaController.clear();
    cidadeController.clear();
  }

  
    void listarClientes() {
    showDialog(
     context: context,
     builder: (BuildContext context) {
        return AlertDialog(
         title: Text('Clientes Cadastrados'),
         content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: listaClientes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listaClientes[index].nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CPF: ${listaClientes[index].cpf}'),
                      Text('Telefone: ${listaClientes[index].numeroTelefone}'),
                      Text('Bairro: ${listaClientes[index].bairro}'),
                      Text('Rua: ${listaClientes[index].rua}'),
                      Text('Cidade: ${listaClientes[index].cidade}'),
                    ],
                  ),
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
        title: Text('Cadastro de Cliente'),
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
            TextField(
              controller: bairroController,
              decoration: InputDecoration(
                labelText: 'Bairro',
              ),
            ),
            TextField(
              controller: ruaController,
              decoration: InputDecoration(
                labelText: 'Rua',
              ),
            ),
            TextField(
              controller: cidadeController,
              decoration: InputDecoration(
                labelText: 'Cidade',
              ),
            ),
            ElevatedButton(
              onPressed: cadastrarCliente,
              child: Text('Cadastrar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: listarClientes,
              child: Text('Listar'),
            ),
          ],
        ),
      ),
    );
  }
}
