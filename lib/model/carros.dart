import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Carros {
  String id;
  String modelo;
  String marca;

  Carros({required this.id, required this.modelo, required this.marca});

  // Criando um Carros a partir de um DocumentSnapshot
  factory Carros.fromSnapshot(DocumentSnapshot snapshot) {
    return Carros(
      id: snapshot.id,
      modelo: snapshot['modelo'] ?? '',
      marca: snapshot['marca'] ?? '',
    );
  }

  // Convertendo um Carros para Map
  Map<String, dynamic> toMap() {
    return {
      'modelo': modelo,
      'marca': marca,
    };
  }
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
