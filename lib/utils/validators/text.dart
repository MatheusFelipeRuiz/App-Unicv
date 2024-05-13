class TextValidator {
  static String? validate(String? value,
      {int minLength = 0, int maxLength = 100}) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    if (value.length < minLength) {
      return 'O texto deve ter no mínimo $minLength caracteres';
    }
    if (value.length > maxLength) {
      return 'O texto deve ter no máximo $maxLength caracteres';
    }
    return null; // Retorno nulo indica que o texto é válido
  }
}
