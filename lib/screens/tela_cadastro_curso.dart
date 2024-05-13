import 'package:app_unicv/utils/validators/text.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/nav/back_navigator.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';

class TelaCadastroCurso extends StatefulWidget {
  const TelaCadastroCurso({super.key});

  @override
  State<TelaCadastroCurso> createState() => _TelaCadastroCursoState();
}

class _TelaCadastroCursoState extends State<TelaCadastroCurso> {
  final _keyForm = GlobalKey<FormState>();

  TextEditingController _cursoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Curso',
      home: Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const BackNavigator(),
                const SpaceWidget(spaceWidth: 0, spaceHeight: 50),
                Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextInput(
                        label: 'Curso',
                        controller: _cursoController,
                        tipoTeclado: TextInputType.text,
                        validator: (value) => TextValidator.validate(value,
                            minLength: 3, maxLength: 30),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 500),
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
