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
      'codigo': codigo.toString(),
    };
  }

  factory Academico.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return Academico(
      id: documentId,
      designacao: data['designacao'],
      curso: data['curso'],
      turma: data['turma'],
      nome: data['nome'],
      email: data['email'],
      senha: '',
      codigo: int.parse(data['codigo']),
    );
  }
}
