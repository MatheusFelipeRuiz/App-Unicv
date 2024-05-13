import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/screens/tela_cadastro_aluno.dart';
import 'package:app_unicv/services/auth/autentificacao.dart';
import 'package:app_unicv/utils/validators/email.dart';
import 'package:app_unicv/utils/validators/password.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:app_unicv/core/snackbar.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveForm = GlobalKey<FormState>();
  bool _senhaVisivel = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  AutentificacaoServico _authServico = AutentificacaoServico();

  void _enviar({required BuildContext context}) async {
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (!_chaveForm.currentState!.validate()) {
      return;
    }

    /*
      _authServico
          .cadastrarUsuario(email: email, senha: senha)
          .then((String? erro) => {
                if (erro != null)
                  {mostrarSnackBar(context: context, text: erro)}
                else
                  {
                    mostrarSnackBar(
                        context: context,
                        text: "Cadastrado realizado com sucesso!",
                        isError: false)
                  }
              });
    }
    */
    _authServico.logar(email: email, senha: senha).then((String? erro) => {
          if (erro != null)
            {
              mostrarSnackBar(
                  context: context,
                  text: "E-mail ou senha incorretos, tente novamente!")
            }
          else
            {
              // mostrarSnackBar(
              //     context: context,
              //     text: "Usuário logado com sucesso!",
              //     isError: false)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TelaCadastroAluno(),
                ),
              )
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        focusColor: Colors.black,
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: AppColors.mainYellow,
        ),
      ),
      home: Scaffold(
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
                      MainButton(label: 'Entrar', onPressed: () {}),
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
