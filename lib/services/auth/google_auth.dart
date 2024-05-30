import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/services/academico_service.dart';
import 'package:app_unicv/utils/validators/email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class GoogleAuthService {
  Future<dynamic?> signInWithGoogle() async {
    AcademicoService academicoService = AcademicoService();
    List<dynamic> usuarioAcademico = [];
    final RegExp regexEmailAlu = RegExp(r'^.*@aluno\.unicv\.edu\.br$');

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      Academico? academicoCadastrado =
          await academicoService.getAcademicoByEmail(googleUser.email);
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      if (EmailValidator.validate(googleUser.email) != null) {
        throw FirebaseAuthException(
          code: 'e-mail-invalid',
        );
      }

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (academicoCadastrado == null) {
        bool isAluno = regexEmailAlu.hasMatch(googleUser.email);

        Academico academico = Academico(
          nome: googleUser.displayName,
          email: googleUser.email,
          codigo: isAluno ? 0 : 100,
          designacao: isAluno ? 'Aluno' : 'Professor',
          senha: '',
          foto: user?.photoURL,
        );

        usuarioAcademico.add(academico);
      } else {
        academicoCadastrado.foto = user!.photoURL;
        academicoService.atualizarAcademico(academicoCadastrado);

        usuarioAcademico.add(academicoCadastrado);
      }

      if (user != null) {
        usuarioAcademico.add(user);
      }

      return usuarioAcademico;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      print('Erro: $e');
    }
    return null;
  }
}
