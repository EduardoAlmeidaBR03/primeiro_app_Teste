import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class OrdemServico {
  String id;
  String cliente;
  String carro;
  String funcionario;
  String placa;
  

  OrdemServico({
    required this.id,
    required this.cliente,
    required this.carro,
    required this.funcionario,
    required this.placa,
    
  });

  // Criando uma Ordem de Serviço a partir de um DocumentSnapshot
  factory OrdemServico.fromSnapshot(DocumentSnapshot snapshot) {
    return OrdemServico(
      id: snapshot.id,
      cliente: snapshot['cliente'] ?? '',
      carro: snapshot['carro'] ?? '',
      funcionario: snapshot['funcionario'] ?? '',
      placa: snapshot['placa'] ?? '',
       );
  }


  // Convertendo uma Ordem de Serviço para Map
  Map<String, dynamic> toMap() {
    return {
      'cliente': cliente,
      'carro': carro,
      'funcionario': funcionario,
      'placa': placa,
    };
  }
}

FirebaseDatabase database = FirebaseDatabase.instance;
