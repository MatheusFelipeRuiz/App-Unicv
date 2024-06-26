import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/screens/tela_cadastro_academico.dart';
import 'package:app_unicv/screens/tela_cadastro_academico_google.dart';
import 'package:app_unicv/screens/tela_cadastro_aviso.dart';
import 'package:app_unicv/screens/tela_cadastro_curso.dart';
import 'package:app_unicv/screens/tela_cadastro_turma.dart';
import 'package:app_unicv/screens/tela_home_academico.dart';
import 'package:app_unicv/screens/tela_informacoes_academico.dart';
import 'package:app_unicv/screens/tela_login.dart';
import 'package:app_unicv/screens/tela_reset_senha.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationUtil {
  static void direcionarPara(BuildContext context, String rota,
      [Academico? academico, User? usuario]) {
    Widget telaAtual;
    switch (rota) {
      case '/cadastro-academico':
        telaAtual = const TelaCadastroAcademico();
        break;
      case '/cadastro-academico-google':
        telaAtual = TelaCadastroAcademicoGoogle(
          academico: academico!,
          usuario: usuario!,
        );
        break;
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
      case '/info-academico':
        telaAtual = TelaInfoAcademico(academico: academico!);
        break;
      case '/reset-senha':
        telaAtual = const TelaResetSenha();
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
