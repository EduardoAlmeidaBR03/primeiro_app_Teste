import 'package:flutter/material.dart';
import 'package:primeiro_app/model/cadastro_ordem_servico.dart';
import 'package:primeiro_app/model/cadastro_tipo_servico.dart';
import 'package:primeiro_app/model/carro.dart';
import 'package:primeiro_app/model/cliente.dart';
import 'package:primeiro_app/model/funcionario.dart';





void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistema de Lava Jato'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Justifica os botões na tela
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroFuncionario()),
                  );
                },
                child: Text('Cadastro de Funcionário'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroCliente()),
                  );
                },
                child: Text('Cadastro de Cliente'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroCarro()),
                  );
                },
                child: Text('Cadastro de Carro'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroTipoServico()),
                  );
                },
                child: Text('Cadastro de Tipo de Serviço'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroOrdemServico()),
                  );
                },
                child: Text('Cadastro de Ordem de Serviço'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro_tipo_servico');
              },
              child: Text('Cadastro de Tipo de Serviço'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro_ordem_servico');
              },
              child: Text('Cadastro de Ordem de Serviço'),
            ),
          ],
        ),
      ),
    );
  }
}
