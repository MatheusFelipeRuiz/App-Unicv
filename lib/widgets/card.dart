import 'package:app_unicv/common/colors.dart';
import 'package:flutter/material.dart';

class CardHome extends StatefulWidget {
  final String titulo;
  final String descricao;
  final String autor;
  final String dataHora;

  const CardHome({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.autor,
    required this.dataHora,
  });

  @override
  State<CardHome> createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: 350,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        border: Border.all(color: AppColors.mainYellow),
      ),
      child: Card(
        borderOnForeground: false,
        margin: EdgeInsets.zero,
        shadowColor: AppColors.white,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2, left: 4, right: 4),
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    widget.titulo,
                    maxLines: 1,
                    style: const TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.descricao,
                    maxLines: 3,
                    style: const TextStyle(
                      color: AppColors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              Positioned(
                bottom: 5,
                left: 20,
                child: Text(
                  maxLines: 1,
                  'Autor: ${widget.autor} - Data: ${widget.dataHora}',
                  style: const TextStyle(
                      color: AppColors.black,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
