import 'package:app_unicv/screens/tela_cadastro_aluno.dart';
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
      initialRoute: '/cadastro-aluno', // Rota inicial
      routes: {
        '/': (context) => TelaLogin(),
        '/cadastro-aluno': (context) => const TelaCadastroAluno(),
      },
    );
  }
}
