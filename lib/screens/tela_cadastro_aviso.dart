import 'package:app_unicv/utils/validators/text.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/nav/back_navigator.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';

class TelaCadastroAviso extends StatefulWidget {
  const TelaCadastroAviso({super.key});

  @override
  State<TelaCadastroAviso> createState() => _TelaCadastroAvisoState();
}

class _TelaCadastroAvisoState extends State<TelaCadastroAviso> {
  final _keyForm = GlobalKey<FormState>();

  TextEditingController _turmaController = TextEditingController();
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Aviso',
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
                        label: 'Turma',
                        controller: _turmaController,
                        tipoTeclado: TextInputType.text,
                        validator: (value) => TextValidator.validate(value,
                            minLength: 3, maxLength: 30),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 20),
                      TextInput(
                        label: 'Título',
                        controller: _tituloController,
                        validator: (value) => TextValidator.validate(value,
                            minLength: 3, maxLength: 30),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 20),
                      TextInput(
                        label: 'Descrição',
                        controller: _descricaoController,
                        validator: (value) => TextValidator.validate(value,
                            minLength: 3, maxLength: 100),
                        maxLinhas: 10,
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 20),
                      MainButton(
                          label: 'Avisar',
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
