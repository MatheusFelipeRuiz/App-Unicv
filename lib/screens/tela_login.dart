import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/services/academico_service.dart';
import 'package:app_unicv/services/auth/google_auth.dart';
import 'package:app_unicv/utils/error_message.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:app_unicv/utils/snackbar.dart';
import 'package:app_unicv/utils/validators/email.dart';
import 'package:app_unicv/utils/validators/password.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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

  void _signWithGoogle() async {
    try {
      GoogleAuthService googleAuthService = GoogleAuthService();
      List<dynamic> objetos = await googleAuthService.signInWithGoogle();

      if (objetos.isNotEmpty && objetos.length == 2) {
        if (objetos[0].toMap().containsKey('turma')) {
          if (objetos[0].toMap()['turma'] != null) {
            NavigationUtil.direcionarPara(
                context, '/home-academico', objetos[0]);
          } else {
            NavigationUtil.direcionarPara(
                context, '/cadastro-academico-google', objetos[0], objetos[1]);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Exceção lançada!');
      SnackBarMessage.showErrorSnackbar(
          context, ErrorMessage.definirMensagemErro(e.code));
    }
  }

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
        print(academico.email);
        academico =
            (await academicoService.getAcademicoByEmail(academico.email))!;

        NavigationUtil.direcionarPara(context, '/home-academico', academico);
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
        child: SingleChildScrollView(
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
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        onPressed: () {
                          NavigationUtil.direcionarPara(
                              context, '/reset-senha');
                        },
                        child: const Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(color: AppColors.mainYellow),
                        ),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                      _isLoading
                          ? const SpinnerProgressIndicator()
                          : MainButton(
                              label: 'Entrar',
                              onPressed: _logar,
                            ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 20),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            NavigationUtil.direcionarPara(
                                context, '/cadastro-academico');
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 15,
                            ),
                            backgroundColor: AppColors.black,
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: const Text('Cadastrar',
                              style: TextStyle(
                                  fontSize: 20, color: AppColors.white)),
                        ),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 20),
                      SignInButton(
                        Buttons.Google,
                        onPressed: _signWithGoogle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
