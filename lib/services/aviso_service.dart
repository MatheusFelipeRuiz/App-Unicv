import 'package:app_unicv/models/aviso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvisoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Aviso>> getAvisos() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('avisos').orderBy('dataHora').get();
      return querySnapshot.docs.map((doc) {
        return Aviso.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Erro ao buscar avisos: $e');
      return [];
    }
  }
}
