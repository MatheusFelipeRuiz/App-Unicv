import 'package:app_unicv/models/curso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CursoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Curso>> getCursos() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('cursos').orderBy('curso').get();
      return querySnapshot.docs.map((doc) {
        return Curso.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Erro ao buscar cursos: $e');
      return [];
    }
  }
}
