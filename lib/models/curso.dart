import 'package:cloud_firestore/cloud_firestore.dart';

class Curso {
  String? id;
  String curso;

  Curso({
    this.id,
    required this.curso,
  });

  Map<String, dynamic> toMap() {
    return {
      'curso': curso,
    };
  }

  factory Curso.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Curso(
      id: doc.id,
      curso: data['curso'],
    );
  }
}
