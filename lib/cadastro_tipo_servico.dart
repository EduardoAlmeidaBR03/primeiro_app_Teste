import 'package:flutter/material.dart';

class TipoServico {
  String nome;
  String descricao; // Adicione a descrição do tipo de serviço
  double valor;

  TipoServico({required this.nome, required this.descricao, required this.valor});
}

class CadastroTipoServico extends StatefulWidget {
  @override
  _CadastroTipoServicoState createState() => _CadastroTipoServicoState();
}

class _CadastroTipoServicoState extends State<CadastroTipoServico> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController(); // Controlador para a descrição
  TextEditingController valorController = TextEditingController();

  List<TipoServico> tiposServico = [];

  void cadastrarTipoServico() {
    String nome = nomeController.text;
    String descricao = descricaoController.text; // Obtenha a descrição
    double valor = double.parse(valorController.text);

    TipoServico novoTipoServico = TipoServico(nome: nome, descricao: descricao, valor: valor);

    setState(() {
      tiposServico.add(novoTipoServico);
    });

    nomeController.clear();
    descricaoController.clear(); // Limpe o campo de descrição
    valorController.clear();
  }

  void listarTiposServico() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tipos de Serviço Cadastrados'),
          content: Column(
            children: tiposServico.map((tipoServico) => Text('${tipoServico.nome} - ${tipoServico.descricao} - R\$ ${tipoServico.valor.toStringAsFixed(2)}')).toList(),
          ),
          actions: [
            ElevatedButton(
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
        title: Text('Cadastro de Tipo de Serviço'),
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
              controller: descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição', // Campo de descrição
              ),
            ),
            TextField(
              controller: valorController,
              decoration: InputDecoration(
                labelText: 'Valor',
              ),
            ),
            ElevatedButton(
              onPressed: cadastrarTipoServico,
              child: Text('Cadastrar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: listarTiposServico,
              child: Text('Listar'),
            ),
          ],
        ),
      ),
    );
  }
}
