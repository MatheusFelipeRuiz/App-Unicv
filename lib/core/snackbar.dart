import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

mostrarSnackBar(
    {required BuildContext context,
    required String text,
    bool isError = true}) {
  SnackBar snackBar = SnackBar(
    content: Center(
      child: Text(
        text,
      ),
    ),
    backgroundColor: isError ? Colors.red : Colors.green,
    duration: const Duration(
      seconds: 10,
    ),
    action: SnackBarAction(
      label: "X",
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
