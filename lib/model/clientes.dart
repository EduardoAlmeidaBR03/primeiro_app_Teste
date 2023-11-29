import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Clientes {
  String id;
  String nome;
  String cpf;
  String contato;
  String endereco;

  Clientes({required this.id, required this.nome, required this.cpf, required this.contato, required this.endereco});

  factory Clientes.fromSnapshot(DocumentSnapshot snapshot) {
    return Clientes(
      id: snapshot.id,
      nome: snapshot['nome'] ?? '',
      cpf: snapshot['cpf'] ?? '',
      contato: snapshot['contato'] ?? '',
      endereco: snapshot['endereco'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpf': cpf,
      'contato': contato,
      'endereco': endereco,
    };
  }
}

FirebaseDatabase database = FirebaseDatabase.instance;