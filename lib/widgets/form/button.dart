import 'package:app_unicv/common/colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;

  final buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15),
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      backgroundColor: AppColors.green,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)));

  MainButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, color: AppColors.white),
        ),
      ),
    );
  }
}
