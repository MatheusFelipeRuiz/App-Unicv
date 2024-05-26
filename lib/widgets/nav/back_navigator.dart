import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

class BackNavigator extends StatelessWidget {
  final Academico academico;

  const BackNavigator({
    super.key,
    required this.academico,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(10),
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => AppColors.white,
              ),
            ),
            onPressed: () {
              NavigationUtil.direcionarPara(
                  context, '/home-academico', academico);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.mainYellow,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          width: 200,
          child: Image.asset('img/logo-unicv.png'),
        ),
      ],
    );
  }
}
