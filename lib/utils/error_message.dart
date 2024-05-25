class ErrorMessage {
  static String definirMensagemErro(String codigo) {
    switch (codigo) {
      case 'email-already-in-use':
        return 'O endereço de e-mail já está cadastrado!';
      case 'invalid-credential':
        return 'Credencial inválida. Por favor, verifique seus dados de login.';
      case 'user-not-found':
        return 'Usuário não encontrado. Por favor, verifique seus dados de login.';
      case 'wrong-password':
        return 'Usuário ou Senha incorreta. Por favor, tente novamente.';
      default:
        return 'Erro:  $codigo - Contate o suporte da UNICV no número (99) 9999-99999';
    }
  }
}
