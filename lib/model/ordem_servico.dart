import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class OrdemServico {
  String id;
  String cliente;
  String carro;
  String funcionario;
  DateTime dataInicio;
  DateTime dataTermino;

  OrdemServico({
    required this.id,
    required this.cliente,
    required this.carro,
    required this.funcionario,
    required this.dataInicio,
    required this.dataTermino,
  });

  // Criando uma Ordem de Serviço a partir de um DocumentSnapshot
  factory OrdemServico.fromSnapshot(DocumentSnapshot snapshot) {
    return OrdemServico(
      id: snapshot.id,
      cliente: snapshot['cliente'] ?? '',
      carro: snapshot['carro'] ?? '',
      funcionario: snapshot['funcionario'] ?? '',
      dataInicio: (snapshot['dataInicio'] as Timestamp).toDate(),
      dataTermino: (snapshot['dataTermino'] as Timestamp).toDate(),
    );
  }

  // Convertendo uma Ordem de Serviço para Map
  Map<String, dynamic> toMap() {
    return {
      'cliente': cliente,
      'carro': carro,
      'funcionario': funcionario,
      'dataInicio': dataInicio,
      'dataTermino': dataTermino,
    };
  }
}

FirebaseDatabase database = FirebaseDatabase.instance;
