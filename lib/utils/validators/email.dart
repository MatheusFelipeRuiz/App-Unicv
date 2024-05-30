class EmailValidator {
  static final RegExp regexEmailProf = RegExp(r'^prof_.*@unicv\.edu\.br$');
  static final RegExp regexEmailAlu = RegExp(r'^.*@aluno\.unicv\.edu\.br$');

  static String? validate(String? email) {
    if (email == null || email.isEmpty) {
      return 'Por favor, digite seu e-mail';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Por favor, digite um e-mail válido';
    }

    if (!regexEmailProf.hasMatch(email) && !regexEmailAlu.hasMatch(email)) {
      return 'Por favor, insira seu e-mail acadêmico';
    }

    return null;
  }

  static String? validaDesignacaoComEmail(String designacao, String email) {
    if (validate(email) != null) {
      return validate(email);
    }
    print('Designação: $designacao');
    print('E-mail: $email');

    switch (designacao) {
      case 'Aluno':
        if (!regexEmailAlu.hasMatch(email)) {
          return 'E-mail/designação divergentes, insira seu e-mail de aluno';
        }
      case 'Professor':
      case 'Coordenador':
        if (!regexEmailProf.hasMatch(email)) {
          return 'E-mail/designação divergentes, insira seu e-mail de professor/coordenador';
        }
    }
    return null;
  }
}
