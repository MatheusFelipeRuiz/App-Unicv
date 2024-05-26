import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/models/aviso.dart';
import 'package:app_unicv/services/aviso_service.dart';
import 'package:app_unicv/widgets/bottom_aluno.dart';
import 'package:app_unicv/widgets/bottom_profcoord.dart';
import 'package:app_unicv/widgets/card.dart';
import 'package:app_unicv/widgets/nav/navbar_home.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TelaHomeAcademico extends StatefulWidget {
  final Academico academico;
  const TelaHomeAcademico({super.key, required this.academico});

  @override
  State<TelaHomeAcademico> createState() => _TelaHomeAcademicoState();
}

class _TelaHomeAcademicoState extends State<TelaHomeAcademico> {
  bool _isAluno = false;
  List<Aviso> _avisos = [];
  bool? _isLoading;

  Future<void> _loadAvisos() async {
    try {
      setState(() {
        _isLoading = true;
      });
      AvisoService avisoService = AvisoService();
      List<Aviso> avisos = await avisoService.getAvisos();

      setState(() {
        _avisos.addAll(avisos);
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar turmas: $e');
    }
  }

  void _showDetalhesAviso(Aviso aviso) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                aviso.titulo,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.green),
              ),
              const SizedBox(height: 16),
              Text(
                aviso.descricao,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Data: ${DateFormat('dd/MM/yyyy HH:mm').format(aviso.dataHora)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Autor: ${aviso.autor}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAvisos();
    _isAluno = widget.academico.designacao == 'Aluno';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const NavbarHome(),
          const SpaceWidget(spaceWidth: 0, spaceHeight: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Avisos',
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.mainYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_avisos.isEmpty && !_isLoading!) ...[
                  const SpaceWidget(spaceWidth: 0, spaceHeight: 50),
                  const Text(
                    'Sem avisos no momento. Assim que houver avisos será mostrada na tela inicial do seu aplicativo',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ] else if (_avisos.isEmpty && _isLoading!) ...[
                  const SpaceWidget(spaceWidth: 0, spaceHeight: 80),
                  const SpinnerProgressIndicator()
                ] else ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _avisos.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _showDetalhesAviso(_avisos[index]),
                          child: CardHome(
                            titulo: _avisos[index].titulo,
                            descricao: _avisos[index].descricao,
                          ),
                        );
                      },
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _isAluno
          ? const BottomNavigationAluno()
          : BottomNavigationProfCoord(
              academico: widget.academico,
            ),
    );
  }
}
