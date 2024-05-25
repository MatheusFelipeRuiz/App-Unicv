import 'package:app_unicv/models/aluno.dart';
import 'package:app_unicv/models/curso.dart';
import 'package:app_unicv/models/designacao.dart';
import 'package:app_unicv/models/turma.dart';
import 'package:app_unicv/screens/tela_home_aluno.dart';
import 'package:app_unicv/services/aluno_service.dart';
import 'package:app_unicv/services/curso_service.dart';
import 'package:app_unicv/services/designacao_service.dart';
import 'package:app_unicv/services/turma_service.dart';
import 'package:app_unicv/utils/validators/dropdown.dart';
import 'package:app_unicv/utils/validators/email.dart';
import 'package:app_unicv/utils/validators/password.dart';
import 'package:app_unicv/utils/validators/text.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/dropdown.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaCadastroAluno extends StatefulWidget {
  const TelaCadastroAluno({super.key});

  @override
  State<TelaCadastroAluno> createState() => _TelaCadastroAlunoState();
}

class _TelaCadastroAlunoState extends State<TelaCadastroAluno> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool _isLoading = false;
  String? _designacao;
  String? _curso;
  String? _turma;
  List<Designacao> _designacoes = [];
  List<Curso> _cursos = [];
  List<Turma> _turmas = [];

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadDesignacoes();
    _loadCursos();
    _loadTurmas();
  }

  Future<void> _loadDesignacoes() async {
    try {
      DesignacaoService designacaoService = DesignacaoService();
      List<Designacao> designacoes = await designacaoService.getDesignacoes();
      setState(() {
        _designacoes = designacoes;
        _designacao =
            _designacoes.isNotEmpty ? _designacoes.first.designacao : null;
      });
    } catch (e) {
      print('Erro ao carregar designações: $e');
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

  void _cadastrar() async {
    String email = _emailController.text;
    String senha = _senhaController.text;
    String nome = _nomeController.text;

    if (!_keyForm.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Aluno aluno = Aluno(
      designacao: _designacao!,
      curso: _curso!,
      turma: _turma!,
      nome: nome,
      email: email,
      senha: senha,
    );

    AlunoService alunoService = AlunoService();
    alunoService.cadastrarAluno(aluno);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const TelaHomeAluno(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Aluno',
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
            Container(
              child: Form(
                key: _keyForm,
                child: Column(
                  children: [
                    Dropdown(
                      value: _designacao,
                      onChanged: (String? value) {
                        setState(() {
                          _designacao = value;
                        });
                      },
                      label: 'Designação',
                      items: _designacoes
                          .map((designacao) => designacao.designacao)
                          .toList(),
                      validator: (value) =>
                          DropdownValidator.validate(value, 'Designação'),
                    ),
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
                      controller: _senhaController,
                      tipoTeclado: TextInputType.visiblePassword,
                      validator: (value) => PasswordValidator.validate(value),
                      inputSenha: true,
                    ),
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
            const SpaceWidget(spaceWidth: 0, spaceHeight: 14),
          ],
        )),
      )),
    );
  }
}
