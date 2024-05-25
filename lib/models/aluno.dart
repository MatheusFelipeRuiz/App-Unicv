class Aluno {
  String? id;
  String nome;
  String email;
  String senha;
  String designacao;
  String curso;
  String turma;

  Aluno({
    this.id,
    required this.designacao,
    required this.curso,
    required this.nome,
    required this.turma,
    required this.email,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'designacao': designacao,
      'curso': curso,
      'turma': turma,
    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'],
      designacao: map['designacao'],
      curso: map['curso'],
      turma: map['turma'],
      nome: map['nome'],
      email: map['email'],
      senha: '', // A senha não deve ser armazenada diretamente
    );
  }
}
