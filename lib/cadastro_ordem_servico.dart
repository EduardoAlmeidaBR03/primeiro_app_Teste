import 'package:flutter/material.dart';

class TipoServico {
  String nome;
  double valor;
  TipoServico({required this.nome, required this.valor});
}

class OrdemServico {
  String descricao;
  String cliente;
  List<TipoServico> servicos;
  OrdemServico({required this.descricao, required this.cliente, required this.servicos});
}

class CadastroOrdemServico extends StatefulWidget {
  @override
  _CadastroOrdemServicoState createState() => _CadastroOrdemServicoState();
}

class _CadastroOrdemServicoState extends State<CadastroOrdemServico> {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController clienteController = TextEditingController();
  TextEditingController servicosController = TextEditingController();

  List<OrdemServico> ordensServico = [];

  void cadastrarOrdemServico() {
    String descricao = descricaoController.text;
    String cliente = clienteController.text;
    List<TipoServico> servicos = [];

    String servicosText = servicosController.text;
    List<String> servicosList = servicosText.split(',');

    for (String servico in servicosList) {
      String nome = servico.trim();
      double valor = 0.0; // Defina o valor do serviço conforme necessário
      TipoServico tipoServico = TipoServico(nome: nome, valor: valor);
      servicos.add(tipoServico);
    }

    OrdemServico novaOrdemServico = OrdemServico(descricao: descricao, cliente: cliente, servicos: servicos);

    setState(() {
      ordensServico.add(novaOrdemServico);
    });

    descricaoController.clear();
    clienteController.clear();
    servicosController.clear();
  }

  void listarOrdensServico() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ordens de Serviço Cadastradas'),
          content: Column(
            children: ordensServico.map((ordemServico) => Text('${ordemServico.descricao} - ${ordemServico.cliente}')).toList(),
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
        title: Text('Cadastro de Ordem de Serviço'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            TextField(
              controller: clienteController,
              decoration: InputDecoration(
                labelText: 'Cliente',
              ),
            ),
            TextField(
              controller: servicosController,
              decoration: InputDecoration(
                labelText: 'Serviços (separados por vírgula)',
              ),
            ),
            ElevatedButton(
              onPressed: cadastrarOrdemServico,
              child: Text('Cadastrar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: listarOrdensServico,
              child: Text('Listar'),
            ),
          ],
        ),
      ),
    );
  }
}
