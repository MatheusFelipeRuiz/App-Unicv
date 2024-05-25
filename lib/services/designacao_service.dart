import 'package:app_unicv/models/designacao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DesignacaoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Designacao>> getDesignacoes() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('designacoes')
          .orderBy('designacao')
          .get();

      return querySnapshot.docs.map((doc) {
        return Designacao.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Erro ao consultar designações: $e');
      return [];
    }
  }
}
