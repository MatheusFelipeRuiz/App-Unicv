import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/screens/tela_cadastro_aluno.dart';
import 'package:app_unicv/screens/tela_home_aluno.dart';
import 'package:app_unicv/services/auth/autentificacao.dart';
import 'package:app_unicv/utils/validators/email.dart';
import 'package:app_unicv/utils/validators/password.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_unicv/core/snackbar.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveForm = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  AutentificacaoServico _authServico = AutentificacaoServico();
  bool _isLoading = false;

  void _logar() async {
    if (!_chaveForm.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text.trim();
    String senha = _senhaController.text.trim();
    String _errorMessage = '';

    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TelaHomeAluno(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        _errorMessage =
            'Credencial inválida. Por favor, verifique seus dados de login.';
      } else if (e.code == 'user-not-found') {
        _errorMessage =
            'Usuário não encontrado. Por favor, verifique seus dados de login.';
      } else if (e.code == 'wrong-password') {
        _errorMessage = 'Senha incorreta. Por favor, tente novamente.';
      } else {
        _errorMessage = 'Ocorreu um erro: ${e.message}';
      }
      print('Erro: $_errorMessage');
      _showErrorSnackbar(_errorMessage);
    } catch (e) {
      _showErrorSnackbar(
          'Ocorreu um erro inesperado. Por favor, tente novamente.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: Image.asset(
                'img/logo-unicv.png',
                width: 400,
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _chaveForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextInput(
                      label: 'E-mail',
                      controller: _emailController,
                      tipoTeclado: TextInputType.emailAddress,
                      validator: (value) => EmailValidator.validate(value),
                    ),
                    TextInput(
                      label: 'Senha',
                      controller: _senhaController,
                      tipoTeclado: TextInputType.visiblePassword,
                      inputSenha: true,
                      validator: (value) => PasswordValidator.validate(value),
                    ),
                    const SpaceWidget(spaceWidth: 0, spaceHeight: 50),
                    _isLoading
                        ? const SpinnerProgressIndicator()
                        : MainButton(
                            label: 'Entrar',
                            onPressed: _logar,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
