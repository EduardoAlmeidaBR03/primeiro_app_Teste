import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primeiro_app/crud/cadastro_ordem_servico_screen.dart'; 
import 'package:primeiro_app/screens/listascreens/listaordemservico_screens.dart'; 
import 'package:primeiro_app/model/ordem_servico.dart'; 
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class OrdemServicoScreen extends StatefulWidget {
  @override
  _OrdemServicoScreenState createState() => _OrdemServicoScreenState();
}

class _OrdemServicoScreenState extends State<OrdemServicoScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciamento de Ordens de Serviço'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: Text('Criar Ordem de Serviço'),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroOrdemServicoScreen()),
                  );
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: Text('Visualizar Ordens de Serviço'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListaOrdemServicoScreen()),
                  );
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('ordens_servico').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Erro ao carregar ordens de serviço');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      OrdemServico ordemServico = OrdemServico.fromSnapshot(docs[index]);
                      return ListTile(
                        title: Text(ordemServico.cliente),
                        subtitle: Text(ordemServico.carro),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
