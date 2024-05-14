import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/widgets/card.dart';
import 'package:app_unicv/widgets/floating_button.dart';
import 'package:app_unicv/widgets/nav/navbar_home.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:flutter/material.dart';

class TelaHomeCoordenador extends StatefulWidget {
  const TelaHomeCoordenador({super.key});

  @override
  State<TelaHomeCoordenador> createState() => _TelaHomeCoordenadorState();
}

class _TelaHomeCoordenadorState extends State<TelaHomeCoordenador> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        bottomNavigationBar: BottomAppBar(
          color: AppColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatButton(
                onPressed: () {},
                buttonColor: AppColors.white,
                icon: Icons.cast_for_education,
                iconColor: AppColors.mainYellow,
                borderColor: AppColors.green,
              ),
              FloatButton(
                onPressed: () {},
                buttonColor: AppColors.mainYellow,
                icon: Icons.add,
                iconColor: AppColors.white,
                borderColor: AppColors.mainYellow,
              ),
              FloatButton(
                onPressed: () {},
                buttonColor: AppColors.white,
                icon: Icons.people,
                iconColor: AppColors.mainYellow,
                borderColor: AppColors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
