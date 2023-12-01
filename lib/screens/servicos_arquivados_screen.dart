import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServicosArquivadosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços Arquivados'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ordens_servico').where('arquivada', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados'));
          }
          List<DocumentSnapshot> ordens = snapshot.data!.docs;
          return ListView.builder(
            itemCount: ordens.length,
            itemBuilder: (context, index) {
              var ordem = ordens[index];
              return ListTile(
                title: Text('Carro: ${ordem['carro']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Placa: ${ordem['placa']}'),
                    Text('Funcionário: ${ordem['funcionario']}'),
                  ],
                ),
                leading: Text('Cliente: ${ordem['cliente']}'),
              );
            },
          );
        },
      ),
    );
  }
}

