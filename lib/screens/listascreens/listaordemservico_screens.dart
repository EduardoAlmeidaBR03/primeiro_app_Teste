import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primeiro_app/edits/editordemservico.dart';
import 'package:primeiro_app/model/ordem_servico.dart';

class ListaOrdemServicoScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Ordens de Serviço'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('ordens_servico').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erro ao carregar a lista de ordens de serviço.');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var ordemServicoData = docs[index].data() as Map<String, dynamic>;
              OrdemServico ordemServico = OrdemServico(
                id: docs[index].id,
                cliente: ordemServicoData['cliente'],
                carro: ordemServicoData['carro'],
                funcionario: ordemServicoData['funcionario'],
                placa: ordemServicoData['placa'],
                
              );
              return ListTile(
                title: Text(ordemServico.cliente),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Carro: ${ordemServico.carro}'),
                    Text('Funcionário: ${ordemServico.funcionario}'),
                    Text('Placa: ${ordemServico.placa}'),
                    
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EdicaoOrdemServicoScreen(ordemServico: ordemServico),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _excluirOrdemServico(docs[index].id, context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _excluirOrdemServico(String docId, BuildContext context) {
    firestore.collection('ordens_servico').doc(docId).delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ordem de serviço excluída com sucesso.')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao excluir ordem de serviço: $error')));
    });
  }
}
