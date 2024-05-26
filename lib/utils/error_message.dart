class ErrorMessage {
  static String definirMensagemErro(String codigo) {
    switch (codigo) {
      case 'email-already-in-use':
        return 'O endereço de e-mail já está cadastrado!';
      case 'invalid-credential':
        return 'Usuário ou senha inválidos. Por favor, verifique seus dados de login.';
      case 'user-not-found':
        return 'Usuário não encontrado. Por favor, verifique seus dados de login.';
      default:
        return 'Erro:  $codigo - Contate o suporte da UNICV no número (99) 9999-99999';
    }
  }
}
