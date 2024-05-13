import 'package:app_unicv/utils/validators/dropdown.dart';
import 'package:app_unicv/utils/validators/email.dart';
import 'package:app_unicv/utils/validators/password.dart';
import 'package:app_unicv/utils/validators/text.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/dropdown.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';

class TelaCadastroAluno extends StatefulWidget {
  const TelaCadastroAluno({super.key});

  @override
  State<TelaCadastroAluno> createState() => _TelaCadastroAlunoState();
}

class _TelaCadastroAlunoState extends State<TelaCadastroAluno> {
  final _keyForm = GlobalKey<FormState>();
  List<String> designacoes = ['Professor', 'Coordenador', 'Aluno', 'Vagabundo'];
  List<String> cursos = [
    'Análise e desenvolvimento de Sistemas',
    'Engenharia de Software',
    'Engenharia da Computação'
  ];
  List<String> turmas = [
    '1º Semestre',
    '2º Semestre',
    '3º Semestre',
    '4º Semestre',
    '5º Semestre'
  ];

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Aluno',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: 200,
              child: Image.asset('img/logo-unicv.png'),
            ),
            const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
            Form(
              key: _keyForm,
              child: Column(
                children: [
                  Dropdown(
                    label: 'Designação',
                    items: designacoes,
                    validator: (value) =>
                        DropdownValidator.validate(value, 'Designação'),
                  ),
                  const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  Dropdown(
                    label: 'Curso',
                    items: cursos,
                    validator: (value) =>
                        DropdownValidator.validate(value, 'Curso'),
                  ),
                  const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  Dropdown(
                    label: 'Turma',
                    items: turmas,
                    validator: (value) =>
                        DropdownValidator.validate(value, 'Turma'),
                  ),
                  const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  TextInput(
                    label: 'Nome',
                    controller: _nomeController,
                    validator: (value) =>
                        TextValidator.validate(value, minLength: 3),
                  ),
                  const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  TextInput(
                    label: 'E-mail',
                    controller: _emailController,
                    tipoTeclado: TextInputType.emailAddress,
                    validator: (value) => EmailValidator.validate(value),
                  ),
                  const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  TextInput(
                    label: 'Senha',
                    controller: TextEditingController(),
                    tipoTeclado: TextInputType.visiblePassword,
                    validator: (value) => PasswordValidator.validate(value),
                    inputSenha: true,
                  ),
                  const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  MainButton(
                      label: 'Cadastrar',
                      onPressed: () {
                        if (!_keyForm.currentState!.validate()) {
                          return;
                        }
                      }),
                ],
              ),
            ),
            const SpaceWidget(spaceWidth: 0, spaceHeight: 14),
          ],
        )),
      )),
    );
  }
}
