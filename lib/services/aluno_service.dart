import 'package:app_unicv/models/aluno.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlunoService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> cadastrarAluno(Aluno aluno) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: aluno.email,
        password: aluno.senha,
      );

      String uid = userCredential.user!.uid;

      await _firestore.collection('alunos').doc(uid).set(aluno.toMap());
    } on FirebaseException catch (e) {
      print('Erro: $e');
      throw e;
    }
  }
}
