import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/screens/tela_cadastro_aviso.dart';
import 'package:app_unicv/screens/tela_cadastro_curso.dart';
import 'package:app_unicv/screens/tela_cadastro_turma.dart';
import 'package:app_unicv/screens/tela_home_academico.dart';
import 'package:app_unicv/screens/tela_login.dart';
import 'package:flutter/material.dart';

class NavigationUtil {
  static void direcionarPara(BuildContext context, String rota,
      [Academico? academico]) {
    Widget telaAtual;
    switch (rota) {
      case '/cadastro-aviso':
        telaAtual = TelaCadastroAviso(academico: academico!);
        break;
      case '/cadastro-turma':
        telaAtual = TelaCadastroTurma(academico: academico!);
        break;
      case '/cadastro-curso':
        telaAtual = TelaCadastroCurso(academico: academico!);
        break;
      case '/home-academico':
        telaAtual = TelaHomeAcademico(academico: academico!);
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
