import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primeiro_app/model/funcionario.dart';
import 'package:primeiro_app/edits/editfuncionarios.dart'; // Certifique-se de criar o arquivo editfuncionarios.dart

class ListaFuncionariosScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Funcionários'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('funcionarios').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erro ao carregar a lista de funcionários.');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var funcionarioData = docs[index].data() as Map<String, dynamic>;
              Funcionario funcionario = Funcionario(id: docs[index].id, nome: funcionarioData['nome'], cargo: funcionarioData['cargo']);
              return ListTile(
                title: Text(funcionario.nome),
                subtitle: Text(funcionario.cargo),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navegue para a tela de edição de funcionários
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EdicaoFuncionariosScreen(funcionario: funcionario),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _excluirFuncionario(docs[index].id, context);
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

  void _excluirFuncionario(String docId, BuildContext context) {
    firestore.collection('funcionarios').doc(docId).delete().then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Funcionário excluído com sucesso.')));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao excluir funcionário: $error')));
    });
  }
}
