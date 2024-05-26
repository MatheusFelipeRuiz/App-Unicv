import 'package:app_unicv/utils/validators/dropdown.dart';
import 'package:app_unicv/utils/validators/text.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/dropdown.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/nav/back_navigator.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';

class TelaCadastroTurma extends StatefulWidget {
  final String designacao;
  const TelaCadastroTurma({
    super.key,
    required this.designacao,
  });

  @override
  State<TelaCadastroTurma> createState() => _TelaCadastroTurmaState();
}

class _TelaCadastroTurmaState extends State<TelaCadastroTurma> {
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  List<String> cursos = [
    'Análise e desenvolvimento de Sistemas',
    'Engenharia de Software',
    'Engenharia da Computação'
  ];

  TextEditingController _turmaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Turma',
      home: Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                BackNavigator(
                  designacao: widget.designacao,
                ),
                const SpaceWidget(spaceWidth: 0, spaceHeight: 50),
                Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Dropdown(
                        label: 'Curso',
                        items: cursos,
                        validator: (value) =>
                            DropdownValidator.validate(value, 'Curso'),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 20),
                      TextInput(
                        label: 'Turma',
                        controller: _turmaController,
                        validator: (value) => TextValidator.validate(value,
                            minLength: 3, maxLength: 30),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 400),
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
              ],
            )),
      ),
    );
  }
}
