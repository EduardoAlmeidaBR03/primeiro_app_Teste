import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primeiro_app/edits/editordemservico.dart';
import 'package:primeiro_app/model/ordem_servico.dart';

class ListaOrdemServicoScreen extends StatefulWidget {
  @override
  _ListaOrdemServicoScreenState createState() => _ListaOrdemServicoScreenState();
}

class _ListaOrdemServicoScreenState extends State<ListaOrdemServicoScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String _filtroSituacao = 'Todas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Ordens de Serviço'),
        actions: [
          DropdownButton<String>(
            value: _filtroSituacao,
            onChanged: (String? newValue) {
              setState(() {
                _filtroSituacao = newValue!;
              });
            },
            items: <String>['Todas', 'Aberta', 'Finalizada', 'Cancelada']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _filtroSituacao == 'Todas'
            ? firestore.collection('ordens_servico').snapshots()
            : firestore.collection('ordens_servico').where('situacao', isEqualTo: _filtroSituacao).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erro ao carregar a lista de ordens de serviço.');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                descricao: ordemServicoData['descricao'],
                valor: ordemServicoData['valor'],
                situacao: ordemServicoData['situacao'],
                dataCriacao: ordemServicoData['dataCriacao'].toDate(), // Converte o Timestamp para DateTime
              );
              return ListTile(
                title: Text(ordemServico.cliente),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Carro: ${ordemServico.carro}'),
                    Text('Funcionário: ${ordemServico.funcionario}'),
                    Text('Placa: ${ordemServico.placa}'),
                    Text('Descrição: ${ordemServico.descricao}'),
                    Text('Valor: R\$ ${ordemServico.valor}'),
                    Text('Situação: ${ordemServico.situacao}'),
                    Text('Data de Criação: ${ordemServico.dataCriacao.toString()}'), // Exibe a data de criação
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
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        _atualizarSituacaoOrdemServico(docs[index].id, 'Finalizada', context);
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

  void _atualizarSituacaoOrdemServico(String docId, String situacao, BuildContext context) {
    firestore.collection('ordens_servico').doc(docId).update({'situacao': situacao}).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Situação da ordem de serviço atualizada com sucesso.')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao atualizar situação da ordem de serviço: $error')));
    });
  }
}
