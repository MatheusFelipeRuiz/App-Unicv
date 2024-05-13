class NumberValidate {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite o código';
    }

    final numberRegex = RegExp(r'^[0-9]+$');

    if (!numberRegex.hasMatch(value)) {
      return 'Por favor, digite apenas números';
    }
    return null;
  }
}
