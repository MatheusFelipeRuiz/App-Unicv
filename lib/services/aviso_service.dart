import 'package:app_unicv/models/aviso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvisoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Aviso>> getAvisos() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('avisos')
          .orderBy('dataHora', descending: true)
          .get();
      return querySnapshot.docs.map((doc) {
        return Aviso.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Erro ao buscar avisos: $e');
      return [];
    }
  }

  // Future<bool> cadastrarAcademico(Academico academico) async {
  //   try {
  //     UserCredential userCredential =
  //         await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: academico.email,
  //       password: academico.senha,
  //     );

  //     String uid = userCredential.user!.uid;

  //     await _firestore.collection('academicos').doc(uid).set(academico.toMap());
  //     return true;
  //   } on FirebaseException catch (e) {
  //     throw FirebaseAuthException(code: e.code);
  //   }
  // }

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
