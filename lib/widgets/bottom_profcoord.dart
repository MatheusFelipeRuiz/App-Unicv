import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:app_unicv/widgets/floating_button.dart';
import 'package:flutter/material.dart';

class BottomNavigationProfCoord extends StatefulWidget {
  final Academico academico;
  const BottomNavigationProfCoord({
    super.key,
    required this.academico,
  });

  @override
  State<BottomNavigationProfCoord> createState() =>
      _BottomNavigationProfCoordState();
}

class _BottomNavigationProfCoordState extends State<BottomNavigationProfCoord> {
  MainAxisAlignment defineAlinhamentoBotoes(String designacao) {
    switch (designacao) {
      case 'Professor':
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.spaceBetween;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.white,
      child: Row(
        mainAxisAlignment:
            defineAlinhamentoBotoes(widget.academico.designacao!),
        children: [
          if (widget.academico.designacao == 'Coordenador') ...{
            FloatButton(
              heroTag: 'btnCadCursos',
              onPressed: () {
                NavigationUtil.direcionarPara(
                    context, '/cadastro-curso', widget.academico);
              },
              buttonColor: AppColors.white,
              icon: Icons.cast_for_education,
              iconColor: AppColors.mainYellow,
              borderColor: AppColors.green,
            ),
          },
          FloatButton(
            heroTag: 'btnCadAvisos',
            onPressed: () {
              NavigationUtil.direcionarPara(
                  context, '/cadastro-aviso', widget.academico);
            },
            buttonColor: AppColors.mainYellow,
            icon: Icons.add,
            iconColor: AppColors.white,
            borderColor: AppColors.mainYellow,
          ),
          if (widget.academico.designacao == 'Coordenador') ...{
            FloatButton(
              heroTag: 'btnCadTurmas',
              onPressed: () {
                NavigationUtil.direcionarPara(
                    context, '/cadastro-turma', widget.academico);
              },
              buttonColor: AppColors.white,
              icon: Icons.people,
              iconColor: AppColors.mainYellow,
              borderColor: AppColors.green,
            ),
          },
        ],
      ),
    );
  }
}
