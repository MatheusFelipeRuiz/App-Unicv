import 'package:app_unicv/models/turma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TurmaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Turma>> getTurmas() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('turmas').orderBy('turma').get();

      return querySnapshot.docs.map((doc) {
        return Turma.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Erro ao buscar turmas: $e');
      return [];
    }
  }
}
