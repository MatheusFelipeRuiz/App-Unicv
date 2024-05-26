import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/models/curso.dart';
import 'package:app_unicv/services/curso_service.dart';
import 'package:app_unicv/utils/error_message.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:app_unicv/utils/snackbar.dart';
import 'package:app_unicv/utils/validators/text.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/nav/back_navigator.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaCadastroCurso extends StatefulWidget {
  final Academico academico;
  const TelaCadastroCurso({
    super.key,
    required this.academico,
  });

  @override
  State<TelaCadastroCurso> createState() => _TelaCadastroCursoState();
}

class _TelaCadastroCursoState extends State<TelaCadastroCurso> {
  final _keyForm = GlobalKey<FormState>();
  bool? _isLoading = false;
  TextEditingController _cursoController = TextEditingController();

  void _cadastrarCurso() async {
    String descCurso = _cursoController.text.trim();

    if (!_keyForm.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Curso curso = Curso(curso: descCurso);

    try {
      CursoService cursoService = CursoService();
      bool cadastradoComSucesso = await cursoService.cadastrarCurso(curso);

      if (cadastradoComSucesso) {
        NavigationUtil.direcionarPara(
            context, '/home-academico', widget.academico);
      }
    } on FirebaseException catch (e) {
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
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                BackNavigator(
                  academico: widget.academico,
                ),
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
                      if (_isLoading!) ...{
                        const SpinnerProgressIndicator(),
                      } else ...{
                        MainButton(
                            label: 'Cadastrar', onPressed: _cadastrarCurso),
                      }
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
