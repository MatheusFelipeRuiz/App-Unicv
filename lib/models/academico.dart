class Academico {
  String? id;
  String? nome;
  String email;
  String senha;
  int? codigo;
  String? designacao;
  String? curso;
  String? turma;

  Academico({
    this.id,
    this.designacao,
    this.curso,
    this.nome,
    this.turma,
    required this.email,
    required this.senha,
    this.codigo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'designacao': designacao,
      'curso': curso,
      'turma': turma,
      'codigo': codigo,
    };
  }

  factory Academico.fromMap(Map<String, dynamic> map) {
    return Academico(
      id: map['id'],
      designacao: map['designacao'],
      curso: map['curso'],
      turma: map['turma'],
      nome: map['nome'],
      email: map['email'],
      senha: '',
      codigo: map['codigo'],
    );
  }
}
