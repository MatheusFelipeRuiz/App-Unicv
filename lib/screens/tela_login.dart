import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/screens/tela_home_academico.dart';
import 'package:app_unicv/services/academico_service.dart';
import 'package:app_unicv/utils/error_message.dart';
import 'package:app_unicv/utils/snackbar.dart';
import 'package:app_unicv/utils/validators/email.dart';
import 'package:app_unicv/utils/validators/password.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveForm = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool _isLoading = false;

  void _logar() async {
    if (!_chaveForm.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Academico academico = Academico(
      email: _emailController.text.trim(),
      senha: _senhaController.text.trim(),
    );

    try {
      AcademicoService academicoService = AcademicoService();
      bool logadoComSucesso = await academicoService.logar(academico);

      if (logadoComSucesso) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TelaHomeAcademico(
              designacao: 'Aluno',
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      SnackBarMessage.showErrorSnackbar(
          context, ErrorMessage.definirMensagemErro(e.code));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
