import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/screens/tela_cadastro_aluno.dart';
import 'package:app_unicv/services/auth/autentificacao.dart';
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
      theme: ThemeData(
        focusColor: Colors.black,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.mainYellow,
        ),
      ),
      home: Scaffold(
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
                Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _chaveForm,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                                controller: _emailController,
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  labelText: 'E-mail',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@')) {
                                    return 'Por favor, insira um endereço de email válido.';
                                  }
                                  return null;
                                }),
                            TextFormField(
                                controller: _senhaController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _senhaVisivel
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _senhaVisivel = !_senhaVisivel;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: _senhaVisivel,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length < 6) {
                                    return 'A senha deve ter pelo menos 6 caracteres.';
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 50),
                            Builder(builder: (BuildContext context) {
                              return ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(200, 50),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromRGBO(
                                      81,
                                      137,
                                      60,
                                      100,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _enviar(context: context);
                                },
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
