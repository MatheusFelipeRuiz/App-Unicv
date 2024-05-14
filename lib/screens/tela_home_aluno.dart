import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/widgets/card.dart';
import 'package:app_unicv/widgets/nav/navbar_home.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';

class TelaHomeAluno extends StatefulWidget {
  const TelaHomeAluno({super.key});

  @override
  State<TelaHomeAluno> createState() => _TelaHomeAlunoState();
}

class _TelaHomeAlunoState extends State<TelaHomeAluno> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
            children: [
              NavbarHome(),
              SpaceWidget(spaceWidth: 0, spaceHeight: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avisos',
                    style: TextStyle(
                      fontSize: 25,
                      color: AppColors.mainYellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CardHome(
                      titulo: 'Título',
                      descricao:
                          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor'),
                  SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  CardHome(
                      titulo: 'Avaliação de Java adiada',
                      descricao:
                          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor'),
                  SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  CardHome(
                      titulo: 'Professora Renata não virá',
                      descricao:
                          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor'),
                  SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  CardHome(
                      titulo: 'Computadores melhorados',
                      descricao:
                          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor'),
                  SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                  CardHome(
                      titulo:
                          'Professor substituto para máteria de Metodologias Ágeis',
                      descricao:
                          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor'),
                  SpaceWidget(spaceWidth: 0, spaceHeight: 10),
                ],
              )
            ],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomAppBar(
              color: AppColors.green,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Contato',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Text(
                        'Das 08h às 18h',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: AppColors.mainYellow,
                            size: 20,
                          ),
                          SpaceWidget(spaceWidth: 10, spaceHeight: 0),
                          Text(
                            '(44) 3028-4416',
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.mail_outline,
                            color: AppColors.mainYellow,
                          ),
                          SpaceWidget(spaceWidth: 10, spaceHeight: 0),
                          const Text(
                            'contato@unicv.edu.br',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
