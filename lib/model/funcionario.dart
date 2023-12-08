import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Funcionario {
  String id;
  String nome;
  String cargo;
  String contato;

  Funcionario({required this.id, required this.nome, required this.cargo, required this.contato});

  
  factory Funcionario.fromSnapshot(DocumentSnapshot snapshot) {
    return Funcionario(
      id: snapshot.id,
      nome: snapshot['nome'] ?? '',
      cargo: snapshot['cargo'] ?? '',
      contato: snapshot['contato'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cargo': cargo,
      'contato': contato,
    };
  }
}

FirebaseDatabase database = FirebaseDatabase.instance;
