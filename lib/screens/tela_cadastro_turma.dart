import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/models/curso.dart';
import 'package:app_unicv/models/turma.dart';
import 'package:app_unicv/services/curso_service.dart';
import 'package:app_unicv/services/turma_service.dart';
import 'package:app_unicv/utils/error_message.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:app_unicv/utils/snackbar.dart';
import 'package:app_unicv/utils/validators/dropdown.dart';
import 'package:app_unicv/utils/validators/text.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/dropdown.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/nav/back_navigator.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaCadastroTurma extends StatefulWidget {
  final Academico academico;
  const TelaCadastroTurma({
    super.key,
    required this.academico,
  });

  @override
  State<TelaCadastroTurma> createState() => _TelaCadastroTurmaState();
}

class _TelaCadastroTurmaState extends State<TelaCadastroTurma> {
  final _keyForm = GlobalKey<FormState>();
  String? _curso;
  bool _isLoading = false;
  List<Curso> _cursos = [];
  TextEditingController _turmaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCursos();
  }

  Future<void> _loadCursos() async {
    try {
      CursoService cursoService = CursoService();
      List<Curso> cursos = await cursoService.getCursos();
      setState(() {
        _cursos = cursos;
        _curso = _cursos.isNotEmpty ? _cursos.first.curso : null;
      });
    } catch (e) {
      print('Erro ao carregar cursos: $e');
    }
  }

  void _cadastrarTurma() async {
    String descTurma = _turmaController.text.trim();

    if (!_keyForm.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Turma turma = Turma(
      turma: descTurma,
      curso: _curso,
    );
    try {
      TurmaService turmaService = TurmaService();
      bool cadastradoComSucesso = await turmaService.cadastrarTurma(turma);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackNavigator(
                      onPressed: () {
                        NavigationUtil.direcionarPara(
                            context, '/home-academico', widget.academico);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 200,
                      child: Image.asset('img/logo-unicv.png'),
                    ),
                  ],
                ),
                const SpaceWidget(spaceWidth: 0, spaceHeight: 50),
                Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Dropdown(
                        value: _curso,
                        onChanged: (value) {
                          setState(() {
                            _curso = value;
                          });
                        },
                        label: 'Curso',
                        items: _cursos.map((curso) => curso.curso).toList(),
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
                      if (_isLoading) ...{
                        const SpinnerProgressIndicator(),
                      } else ...{
                        MainButton(
                          label: 'Cadastrar',
                          onPressed: _cadastrarTurma,
                        ),
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
