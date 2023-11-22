import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Carros {
  String id;
  String modelo;
  String marca;
  String cor; // Adicionando cor
  String placa; // Adicionando placa

  Carros({required this.id, required this.modelo, required this.marca, required this.cor, required this.placa});

  // Criando um Carros a partir de um DocumentSnapshot
  factory Carros.fromSnapshot(DocumentSnapshot snapshot) {
    return Carros(
      id: snapshot.id,
      modelo: snapshot['modelo'] ?? '',
      marca: snapshot['marca'] ?? '',
      cor: snapshot['cor'] ?? '', // Obtendo cor do snapshot
      placa: snapshot['placa'] ?? '', // Obtendo placa do snapshot
    );
  }

  // Convertendo um Carros para Map
  Map<String, dynamic> toMap() {
    return {
      'modelo': modelo,
      'marca': marca,
      'cor': cor, // Adicionando cor ao mapa
      'placa': placa, // Adicionando placa ao mapa
    };
  }
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
