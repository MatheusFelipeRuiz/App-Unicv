import 'package:app_unicv/screens/tela_cadastro_aluno.dart';
import 'package:app_unicv/screens/tela_cadastro_aviso.dart';
import 'package:app_unicv/screens/tela_cadastro_curso.dart';
import 'package:app_unicv/screens/tela_cadastro_profcoord.dart';
import 'package:app_unicv/screens/tela_cadastro_turma.dart';
import 'package:app_unicv/screens/tela_home_aluno.dart';
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
      initialRoute: '/home-aluno', // Rota inicial
      routes: {
        '/': (context) => const TelaLogin(),
        '/cadastro-aluno': (context) => const TelaCadastroAluno(),
        '/cadastrar-professor-coordenador': (context) =>
            const TelaCadastroProfCor(),
        '/cadastro-aviso': (context) => const TelaCadastroAviso(),
        '/cadastro-curso': (context) => const TelaCadastroCurso(),
        '/cadastro-turma': (context) => const TelaCadastroTurma(),
        '/home-aluno': (context) => const TelaHomeAluno(),
      },
    );
  }
}
