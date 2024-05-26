import 'package:app_unicv/common/colors.dart';
import 'package:flutter/material.dart';

class SnackBarMessage {
  static void showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: AppColors.danger,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccessSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: AppColors.success,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
