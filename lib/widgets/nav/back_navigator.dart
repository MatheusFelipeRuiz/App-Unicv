import 'package:app_unicv/common/colors.dart';
import 'package:flutter/material.dart';

class BackNavigator extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackNavigator({
    super.key,
    required this.onPressed,
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
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.mainYellow,
            ),
          ),
        ),
      ],
    );
  }
}
