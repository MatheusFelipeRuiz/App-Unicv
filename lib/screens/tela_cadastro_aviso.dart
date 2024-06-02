import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/models/aviso.dart';
import 'package:app_unicv/models/turma.dart';
import 'package:app_unicv/services/aviso_service.dart';
import 'package:app_unicv/services/turma_service.dart';
import 'package:app_unicv/utils/error_message.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:app_unicv/utils/snackbar.dart';
import 'package:app_unicv/utils/validators/text.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/dropdown.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/nav/back_navigator.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TelaCadastroAviso extends StatefulWidget {
  final Academico academico;
  const TelaCadastroAviso({
    super.key,
    required this.academico,
  });

  @override
  State<TelaCadastroAviso> createState() => _TelaCadastroAvisoState();
}

class _TelaCadastroAvisoState extends State<TelaCadastroAviso> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  List<Turma> _turmas = [];
  String? _turma;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTurmas();
  }

  void _cadastrarAviso() async {
    String titulo = _tituloController.text.trim();
    String descricao = _descricaoController.text.trim();
    String turma = _turma!;
    
    if (!_keyForm.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Aviso aviso = Aviso(
      titulo: titulo,
      descricao: descricao,
      autor: widget.academico.nome!,
      dataHora: DateTime.now(),
      turma: turma,
    );

    try {
      AvisoService avisoService = AvisoService();
      bool cadastradoComSucesso = await avisoService.cadastrarAviso(aviso);

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
                        value: _turma,
                        onChanged: (String? value) {
                          setState(() {
                            _turma = value;
                          });
                        },
                        label: 'Turma',
                        items: _turmas.map((turma) => turma.turma).toList(),
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
                            minLength: 3, maxLength: 300),
                        maxLinhas: 10,
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 20),
                      _isLoading
                          ? const SpinnerProgressIndicator()
                          : MainButton(
                              label: 'Avisar', onPressed: _cadastrarAviso),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
