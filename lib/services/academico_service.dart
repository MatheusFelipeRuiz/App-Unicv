import 'package:app_unicv/models/academico.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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

  Future<bool> enviarResetSenhaByEmail(String email) async {
    try {
      Academico? academico = await getAcademicoByEmail(email);
      if (academico != null) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        return true;
      }
    } on FirebaseAuth catch (e) {
      print('Erro ao enviar e-mail de reset: ${e}');
    }
    return false;
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

  Future<bool> cadastrarAcademico(Academico academico, [User? usuario]) async {
    try {
      if (usuario != null) {
        print('Cadastrei pelo Google');
        linkEmailSenha(
          usuario,
          academico.email,
          academico.senha,
        );
        await _firestore.collection('academicos').add(academico.toMap());
      } else {
        print('Cadastrei normal');
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: academico.email,
          password: academico.senha,
        );
        String uid = userCredential.user!.uid;
        await _firestore
            .collection('academicos')
            .doc(uid)
            .set(academico.toMap());
      }

      return true;
    } on FirebaseException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

  Future<bool> linkEmailSenha(User user, String email, String senha) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: senha);

      await user.linkWithCredential(credential);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> atualizarAcademico(Academico academico) async {
    try {
      await _firestore
          .collection('academicos')
          .doc(academico.id)
          .update(academico.toMap());
      return true;
    } catch (e) {
      print("Erro ao atualizar acadêmico: $e");
    }
    return false;
  }
}
