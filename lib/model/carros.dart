import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Carros {
  String id;
  String modelo;
  String marca;
  String cor; 
  String placa; 

  Carros({required this.id, required this.modelo, required this.marca, required this.cor, required this.placa});


  factory Carros.fromSnapshot(DocumentSnapshot snapshot) {
    return Carros(
      id: snapshot.id,
      modelo: snapshot['modelo'] ?? '',
      marca: snapshot['marca'] ?? '',
      cor: snapshot['cor'] ?? '', 
      placa: snapshot['placa'] ?? '', 
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'modelo': modelo,
      'marca': marca,
      'cor': cor, 
      'placa': placa, 
    };
  }
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
