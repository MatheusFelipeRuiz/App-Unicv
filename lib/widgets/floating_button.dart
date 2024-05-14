import 'package:app_unicv/common/colors.dart';
import 'package:flutter/material.dart';

class FloatButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final Color borderColor;
  final Color buttonColor;

  const FloatButton({
    super.key,
    required this.onPressed,
    required this.buttonColor,
    required this.icon,
    required this.iconColor,
    required this.borderColor,
  });

  @override
  State<FloatButton> createState() => _FloatButtonState();
}

class _FloatButtonState extends State<FloatButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      isExtended: true,
      shape: CircleBorder(
        side: BorderSide(
          color: widget.borderColor,
          width: 3,
        ),
      ),
      backgroundColor: widget.buttonColor,
      onPressed: widget.onPressed,
      child: Icon(
        widget.icon,
        color: widget.iconColor,
      ),
    );
  }
}
