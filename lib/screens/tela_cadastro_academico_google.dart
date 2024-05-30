import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/models/curso.dart';
import 'package:app_unicv/models/turma.dart';
import 'package:app_unicv/services/academico_service.dart';
import 'package:app_unicv/services/curso_service.dart';
import 'package:app_unicv/services/turma_service.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:app_unicv/utils/snackbar.dart';
import 'package:app_unicv/utils/validators/dropdown.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/dropdown.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelaCadastroAcademicoGoogle extends StatefulWidget {
  final Academico academico;
  final User usuario;
  const TelaCadastroAcademicoGoogle({
    super.key,
    required this.academico,
    required this.usuario,
  });

  @override
  State<TelaCadastroAcademicoGoogle> createState() =>
      _TelaCadastroAcademicoGoogleState();
}

class _TelaCadastroAcademicoGoogleState
    extends State<TelaCadastroAcademicoGoogle> {
  final _keyForm = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _curso;
  String? _turma;
  List<Curso> _cursos = [];
  List<Turma> _turmas = [];

  @override
  void initState() {
    super.initState();
    _loadCursos();
    _loadTurmas();
  }

  void _cadastrar() async {
    if (!_keyForm.currentState!.validate()) {
      return;
    }
    widget.academico.curso = _curso;
    widget.academico.turma = _turma;

    try {
      AcademicoService academicoService = AcademicoService();
      academicoService.cadastrarAcademico(widget.academico, widget.usuario);
      academicoService.enviarResetSenhaByEmail(widget.academico.email);
      NavigationUtil.direcionarPara(
          context, '/home-academico', widget.academico);
      SnackBarMessage.showSuccessSnackbar(context,
          'Cadastrado com sucesso, o e-mail de redefinição da sua senha foi enviado com sucesso!');
    } catch (e) {
      print('Erro ao cadastrar acadêmico via google: $e');
    }
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

  Future<void> _loadTurmas() async {
    try {
      TurmaService turmaService = TurmaService();
      List<Turma> turmas = await turmaService.getTurmas();
      setState(() {
        _turmas = turmas;
        _turma = _turmas.isNotEmpty ? _turmas.first.turma : null;
      });
    } catch (e) {
      print('Erro ao carregar turmas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 200,
                    child: Image.asset('img/logo-unicv.png'),
                  ),
                ],
              ),
              const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
              Container(
                child: Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                      Dropdown(
                        value: _curso,
                        onChanged: (String? value) {
                          setState(() {
                            _curso = value;
                          });
                        },
                        label: 'Curso',
                        items: _cursos.map((curso) => curso.curso).toList(),
                        validator: (value) =>
                            DropdownValidator.validate(value, 'Curso'),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                      Dropdown(
                        value: _turma,
                        onChanged: (String? value) {
                          _turma = value;
                        },
                        label: 'Turma',
                        items: _turmas.map((turma) => turma.turma).toList(),
                        validator: (value) =>
                            DropdownValidator.validate(value, 'Turma'),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                      _isLoading
                          ? const SpinnerProgressIndicator()
                          : MainButton(
                              label: 'Cadastrar',
                              onPressed: _cadastrar,
                            )
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
