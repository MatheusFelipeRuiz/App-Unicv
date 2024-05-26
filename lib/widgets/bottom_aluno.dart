import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';

class BottomNavigationAluno extends StatelessWidget {
  const BottomNavigationAluno({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomAppBar(
        color: AppColors.green,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contato',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Das 08h às 18h',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColors.mainYellow,
                      size: 20,
                    ),
                    SpaceWidget(spaceWidth: 10, spaceHeight: 0),
                    Text(
                      '(44) 3028-4416',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.mail_outline,
                      color: AppColors.mainYellow,
                    ),
                    SpaceWidget(spaceWidth: 10, spaceHeight: 0),
                    Text(
                      'contato@unicv.edu.br',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
