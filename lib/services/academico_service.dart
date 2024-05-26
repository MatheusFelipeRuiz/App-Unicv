import 'package:app_unicv/models/academico.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcademicoService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> logar(Academico academico) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: academico.email,
        password: academico.senha,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

  Future<Academico?> getAcademicoByEmail(String email) async {
    try {
      CollectionReference academicosCollection =
          _firestore.collection('academicos');

      QuerySnapshot querySnapshot = await academicosCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        return Academico.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }
    } catch (e) {
      print('Erro ao buscar usuário por e-mail: $e');
    }
  }

  Future<bool> cadastrarAcademico(Academico academico) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: academico.email,
        password: academico.senha,
      );

      String uid = userCredential.user!.uid;

      await _firestore.collection('academicos').doc(uid).set(academico.toMap());
      return true;
    } on FirebaseException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }
}
