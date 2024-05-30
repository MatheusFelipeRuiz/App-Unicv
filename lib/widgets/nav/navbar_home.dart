import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/models/academico.dart';
import 'package:flutter/material.dart';

class NavbarHome extends StatefulWidget {
  final Academico academico;
  const NavbarHome({
    super.key,
    required this.academico,
  });

  @override
  State<NavbarHome> createState() => _NavbarHomeState();
}

class _NavbarHomeState extends State<NavbarHome> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          width: 150,
          child: Image.asset('img/logo-unicv.png'),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20, top: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.green,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.academico.foto!),
            radius: 20,
          ),
        ),
      ],
    );
  }
}
