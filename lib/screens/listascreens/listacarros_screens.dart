import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primeiro_app/edits/editcarros.dart'; // Supondo que você tenha um arquivo para a tela de edição de carros
import 'package:primeiro_app/model/carros.dart'; // Supondo que você tenha uma classe Carros

class ListaCarrosScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Carros'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('carros').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erro ao carregar a lista de carros.');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var carroData = docs[index].data() as Map<String, dynamic>;
              Carros carro = Carros(
                id: docs[index].id,
                modelo: carroData['modelo'],
                marca: carroData['marca'],
                cor: carroData['cor'], // Obtendo cor do snapshot
                placa: carroData['placa'], // Obtendo placa do snapshot
              );
              return ListTile(
                title: Text(carro.modelo),
                subtitle: Text(carro.marca),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navegue para a tela de edição de carros
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EdicaoCarrosScreen(carro: carro),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _excluirCarro(docs[index].id, context);
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

  void _excluirCarro(String docId, BuildContext context) {
    firestore.collection('carros').doc(docId).delete().then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Carro excluído com sucesso.')));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao excluir carro: $error')));
    });
  }
}
