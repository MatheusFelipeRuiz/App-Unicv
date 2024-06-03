import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/models/academico.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:app_unicv/widgets/nav/back_navigator.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';

class TelaInfoAcademico extends StatefulWidget {
  final Academico academico;
  const TelaInfoAcademico({
    super.key,
    required this.academico,
  });

  @override
  State<TelaInfoAcademico> createState() => _TelaInfoAcademicoState();
}

class _TelaInfoAcademicoState extends State<TelaInfoAcademico> {
  Map<String, dynamic> academicoMap = {};
  final List<String> atributosPermitidos = ['nome', 'email', 'curso', 'turma'];

  final Map<String, String> labels = {
    'nome': 'Nome',
    'email': 'E-mail',
    'curso': 'Curso',
    'turma': 'Turma'
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    academicoMap = widget.academico.toMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SpaceWidget(spaceWidth: 0, spaceHeight: 30),
          Row(
            children: [
              BackNavigator(
                onPressed: () {
                  NavigationUtil.direcionarPara(
                      context, '/home-academico', widget.academico);
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 80),
                padding: const EdgeInsets.only(top: 20),
                width: 150,
                child: Image.asset('img/logo-unicv.png'),
              ),
            ],
          ),
          const SpaceWidget(spaceWidth: 0, spaceHeight: 30),
          Expanded(
            child: Column(children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.academico.foto!),
              ),
              ...academicoMap.entries
                  .where((entry) => atributosPermitidos.contains(entry.key))
                  .map((entry) {
                String chave = entry.key;
                String label = labels[chave] ?? chave;
                return ListTile(
                  title: Text(
                    '$label',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainYellow,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    entry.value,
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ]),
          ),
        ],
      ),
    );
  }
}
