import 'package:app_unicv/screens/tela_cadastro_academico.dart';
import 'package:app_unicv/screens/tela_cadastro_aviso.dart';
import 'package:app_unicv/screens/tela_cadastro_curso.dart';
import 'package:app_unicv/screens/tela_cadastro_turma.dart';
import 'package:app_unicv/screens/tela_home_academico.dart';
import 'package:app_unicv/screens/tela_login.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniChat',
      initialRoute: '/',
      routes: {
        '/': (context) => const TelaLogin(),
        '/cadastro-academico': (context) => const TelaCadastroAcademico(),
        // '/cadastro-aviso': (context) => const TelaCadastroAviso(
        //       designacao: 'Coordenador',
        //     ),
        // '/cadastro-curso': (context) => const TelaCadastroCurso(
        //       designacao: 'Coordenador',
        //     ),
        // '/cadastro-turma': (context) => const TelaCadastroTurma(
        // designacao: 'Professor',
        // ),
        // '/home-academico': (context) => const TelaHomeAcademico(
        // academico: 'Coordenador',
        // ),
      },
    );
  }
}
