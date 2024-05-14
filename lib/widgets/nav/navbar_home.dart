import 'package:app_unicv/common/colors.dart';
import 'package:flutter/material.dart';

class NavbarHome extends StatelessWidget {
  const NavbarHome({super.key});

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
          child: const CircleAvatar(
            backgroundImage: AssetImage('img/logo-usuario.jpg'),
            radius: 20,
          ),
        ),
      ],
    );
  }
}
