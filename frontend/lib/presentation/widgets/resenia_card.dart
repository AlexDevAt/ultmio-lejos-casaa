import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/resenia.dart';
import 'package:lejos_de_casa_front/helpers/formatos/format_date.dart';
import 'package:lejos_de_casa_front/presentation/widgets/foto_perfil.dart';
import 'package:lejos_de_casa_front/presentation/widgets/puntuacino.dart';

class ReseniaCard extends StatelessWidget {
  const ReseniaCard({
    super.key,
    required this.size,
    required this.resenia,
    required this.color,
  });

  final double size;
  final Resenia resenia;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Container(
        width: size,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withValues(),
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(9),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FotoPerfil(
                    color: Colors.grey.shade400,
                    height: 40,
                    width: 40,
                    sizeIcon: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resenia.calificador.nombre,

                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          FormatDate.formatDate(resenia.fecha),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
              Puntuacion(sizeIcon: 18),
              SizedBox(height: 10),
              Text(
                resenia.comentario,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
