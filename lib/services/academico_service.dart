import 'package:app_unicv/models/academico.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcademicoService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> cadastrarAcademico(Academico academico) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: academico.email,
        password: academico.senha,
      );

      String uid = userCredential.user!.uid;

      await _firestore.collection('academicos').doc(uid).set(academico.toMap());
    } on FirebaseException catch (e) {
      print('Erro: $e');
      throw e;
    }
  }
}
