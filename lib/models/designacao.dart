import 'package:cloud_firestore/cloud_firestore.dart';

class Designacao {
  String? id;
  String designacao;

  Designacao({
    this.id,
    required this.designacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'designacao': designacao,
    };
  }

  factory Designacao.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Designacao(
      id: doc.id,
      designacao: data['designacao'],
    );
  }
}
