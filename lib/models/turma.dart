import 'package:cloud_firestore/cloud_firestore.dart';

class Turma {
  String? id;
  String? curso;
  String turma;

  Turma({
    this.id,
    this.curso,
    required this.turma,
  });

  Map<String, dynamic> toMap() {
    return {
      'turma': turma,
      'curso': curso,
    };
  }

  factory Turma.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Turma(
      id: doc.id,
      curso: data['curso'],
      turma: data['turma'],
    );
  }
}
