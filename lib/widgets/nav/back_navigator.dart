import 'package:app_unicv/common/colors.dart';
import 'package:flutter/material.dart';

class BackNavigator extends StatelessWidget {
  const BackNavigator({super.key});

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
            onPressed: () {},
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
