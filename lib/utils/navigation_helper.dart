import 'package:app_unicv/screens/tela_cadastro_aviso.dart';
import 'package:app_unicv/screens/tela_cadastro_curso.dart';
import 'package:app_unicv/screens/tela_cadastro_turma.dart';
import 'package:app_unicv/screens/tela_home_academico.dart';
import 'package:app_unicv/screens/tela_login.dart';
import 'package:flutter/material.dart';

class NavigationUtil {
  static void direcionarPara(BuildContext context, String rota,
      [String? designacaoAcademico]) {
    designacaoAcademico = designacaoAcademico ?? 'Aluno';
    Widget telaAtual;
    switch (rota) {
      case '/cadastro-aviso':
        telaAtual = TelaCadastroAviso(designacao: designacaoAcademico);
        break;
      case '/cadastro-turma':
        telaAtual = TelaCadastroTurma(designacao: designacaoAcademico);
        break;
      case '/cadastro-curso':
        telaAtual = TelaCadastroCurso(designacao: designacaoAcademico);
        break;
      case '/home-academico':
        telaAtual = TelaHomeAcademico(designacao: designacaoAcademico);
        break;
      default:
        telaAtual = const TelaLogin();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => telaAtual,
      ),
    );
  }
}
