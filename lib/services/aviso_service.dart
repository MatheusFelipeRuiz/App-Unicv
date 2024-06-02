import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/models/aviso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvisoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Aviso>> getAvisos(Academico academico) async {
    try {
      Query query = await _firestore.collection('avisos');
      if (academico.designacao != 'Coordenador') {
        query = query.where('turma', isEqualTo: academico.turma);
      }
      QuerySnapshot querySnapshot =
          await query.orderBy('dataHora', descending: true).get();

      return querySnapshot.docs.map((doc) {
        return Aviso.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Erro ao buscar avisos: $e');
      return [];
    }
  }

  Future<bool> cadastrarAviso(Aviso aviso) async {
    try {
      DocumentReference docRef = _firestore.collection('avisos').doc();

      aviso.id = docRef.id;

      await docRef.set(aviso.toMap());

      return true;
    } on FirebaseException catch (e) {
      throw FirebaseException(message: e.code, plugin: 'Error');
    }
  }
}
