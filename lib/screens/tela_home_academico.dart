import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/models/aviso.dart';
import 'package:app_unicv/services/aviso_service.dart';
import 'package:app_unicv/widgets/bottom_aluno.dart';
import 'package:app_unicv/widgets/bottom_profcoord.dart';
import 'package:app_unicv/widgets/card.dart';
import 'package:app_unicv/widgets/nav/navbar_home.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';

class TelaHomeAcademico extends StatefulWidget {
  final String designacao;
  const TelaHomeAcademico({super.key, required this.designacao});

  @override
  State<TelaHomeAcademico> createState() => _TelaHomeAcademicoState();
}

class _TelaHomeAcademicoState extends State<TelaHomeAcademico> {
  bool _isAluno = false;
  List<Aviso> _avisos = [];
  String? _designacao;
  bool _isLoading = false;
  bool _hasMore = true;

  Future<void> _loadAvisos() async {
    if (_isLoading || !_hasMore) return;
    try {
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

  @override
  void initState() {
    super.initState();
    _loadAvisos();
    _isAluno = widget.designacao == 'Aluno';
    _designacao = widget.designacao;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Avisos',
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.mainYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_avisos.isEmpty) ...[
                  const SpaceWidget(spaceWidth: 0, spaceHeight: 50),
                  const Text(
                    'Sem avisos no momento. Assim que houver avisos será mostrada na tela inicial do seu aplicativo',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ] else ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _avisos.length,
                      itemBuilder: (context, index) {
                        return CardHome(
                          titulo: _avisos[index].titulo,
                          descricao: _avisos[index].descricao,
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
          ? BottomNavigationAluno()
          : BottomNavigationProfCoord(
              designacao: _designacao!,
            ),
    );
  }
}
