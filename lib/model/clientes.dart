import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Clientes {
  String id;
  String nome;
  String cpf;

  Clientes({required this.id, required this.nome, required this.cpf});

  factory Clientes.fromSnapshot(DocumentSnapshot snapshot) {
    return Clientes(
      id: snapshot.id,
      nome: snapshot['nome'] ?? '',
      cpf: snapshot['cpf'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpf': cpf,
    };
  }
}

FirebaseDatabase database = FirebaseDatabase.instance;