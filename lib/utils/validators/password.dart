class PasswordValidator {
  static String? validate(String? value) {
    const int minLength = 8;
    const int maxLenght = 100;

    if (value == null || value.isEmpty) {
      return 'Por favor, digite sua senha';
    }
    if (value.length < minLength) {
      return 'A senha deve ter pelo menos $minLength caracteres';
    }

    if (value.length > maxLenght) {
      return 'A senha deve ter no máximo $maxLenght caracteres';
    }

    return null;
  }
}
