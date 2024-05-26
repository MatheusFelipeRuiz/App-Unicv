import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:app_unicv/widgets/floating_button.dart';
import 'package:flutter/material.dart';

class BottomNavigationProfCoord extends StatefulWidget {
  final String designacao;
  const BottomNavigationProfCoord({
    super.key,
    required this.designacao,
  });

  @override
  State<BottomNavigationProfCoord> createState() =>
      _BottomNavigationProfCoordState();
}

class _BottomNavigationProfCoordState extends State<BottomNavigationProfCoord> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.designacao == 'Coordenador') ...{
            FloatButton(
              heroTag: 'btnCadCursos',
              onPressed: () {
                NavigationUtil.direcionarPara(
                    context, '/cadastro-curso', widget.designacao);
              },
              buttonColor: AppColors.white,
              icon: Icons.cast_for_education,
              iconColor: AppColors.mainYellow,
              borderColor: AppColors.green,
            ),
            FloatButton(
              heroTag: 'btnCadAvisos',
              onPressed: () {
                NavigationUtil.direcionarPara(
                    context, '/cadastro-aviso', widget.designacao);
              },
              buttonColor: AppColors.mainYellow,
              icon: Icons.add,
              iconColor: AppColors.white,
              borderColor: AppColors.mainYellow,
            ),
          },
          FloatButton(
            heroTag: 'btnCadTurmas',
            onPressed: () {
              NavigationUtil.direcionarPara(context, '/cadastro-turma', widget.designacao);
            },
            buttonColor: AppColors.white,
            icon: Icons.people,
            iconColor: AppColors.mainYellow,
            borderColor: AppColors.green,
          ),
        ],
      ),
    );
  }
}
