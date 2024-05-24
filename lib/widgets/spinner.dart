import 'package:flutter/material.dart';
import 'package:app_unicv/common/colors.dart';

class SpinnerProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  const SpinnerProgressIndicator({
    super.key,
    this.size = 50.0,
    this.color = AppColors.green,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.strokeWidth = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: backgroundColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
