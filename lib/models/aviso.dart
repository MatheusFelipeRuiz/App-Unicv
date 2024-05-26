import 'package:cloud_firestore/cloud_firestore.dart';

class Aviso {
  String? id;
  String autor;
  String descricao;
  String titulo;
  DateTime dataHora;

  Aviso({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.autor,
    required this.dataHora,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'autor': autor,
      'data': Timestamp.fromDate(dataHora),
    };
  }

  factory Aviso.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Aviso(
      id: doc.id,
      titulo: data['titulo'],
      descricao: data['descricao'],
      autor: data['autor'],
      dataHora: (data['dataHora'] as Timestamp).toDate(),
    );
  }
}
