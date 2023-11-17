import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Funcionario {
  String id;
  String nome;
  String cargo;

  Funcionario({required this.id, required this.nome, required this.cargo});

  // Criando um Funcionario a partir de um DocumentSnapshot
  factory Funcionario.fromSnapshot(DocumentSnapshot snapshot) {
    return Funcionario(
      id: snapshot.id,
      nome: snapshot['nome'] ?? '',
      cargo: snapshot['cargo'] ?? '',
    );
  }

  // Convertendo um Funcionario para Map
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cargo': cargo,
    };
  }
}

FirebaseDatabase database = FirebaseDatabase.instance;
