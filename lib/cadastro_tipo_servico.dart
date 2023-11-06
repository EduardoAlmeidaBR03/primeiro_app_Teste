import 'package:flutter/material.dart';

class TipoServico {
  String nome;
  double valor;
  TipoServico({required this.nome, required this.valor});
}

class CadastroTipoServico extends StatefulWidget {
  @override
  _CadastroTipoServicoState createState() => _CadastroTipoServicoState();
}

class _CadastroTipoServicoState extends State<CadastroTipoServico> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  List<TipoServico> tiposServico = [];

  void cadastrarTipoServico() {
    String nome = nomeController.text;
    double valor = double.parse(valorController.text);

    TipoServico novoTipoServico = TipoServico(nome: nome, valor: valor);

    setState(() {
      tiposServico.add(novoTipoServico);
    });

    nomeController.clear();
    valorController.clear();
  }

  void listarTiposServico() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tipos de Serviço Cadastrados'),
          content: Column(
            children: tiposServico.map((tipoServico) => Text('${tipoServico.nome} - R\$ ${tipoServico.valor.toStringAsFixed(2)}')).toList(),
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
