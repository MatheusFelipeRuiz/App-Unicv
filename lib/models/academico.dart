class Academico {
  String? id;
  String nome;
  String email;
  String senha;
  int codigo;
  String designacao;
  String curso;
  String turma;

  Academico({
    this.id,
    required this.designacao,
    required this.curso,
    required this.nome,
    required this.turma,
    required this.email,
    required this.senha,
    required this.codigo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
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
