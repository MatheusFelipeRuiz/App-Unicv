class DropdownValidator {
  static String? validate(String? value, String tipo) {
    if (value == null || value.isEmpty) {
      if (tipo.substring(tipo.length - 1) == 'a') {
        return 'Por favor, selecione uma $tipo';
      }

      return 'Por favor, selecione um $tipo';
    }

    return null; // Retorno nulo indica que o valor é válido
  }
}
