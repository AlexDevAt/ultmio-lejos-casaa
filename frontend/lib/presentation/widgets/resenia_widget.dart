import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/resenia.dart';
import 'package:lejos_de_casa_front/helpers/formatos/format_date.dart';
import 'package:lejos_de_casa_front/presentation/widgets/foto_perfil.dart';
import 'package:lejos_de_casa_front/presentation/widgets/puntuacino.dart';

class ReseniaWidget extends StatelessWidget {
  const ReseniaWidget({super.key, required this.size, required this.color, required this.resenia});
  final Size size;
  final Resenia resenia;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: size.width,
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
          padding: const EdgeInsets.all(15.0),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FotoPerfil(
                          color: Colors.grey.shade400,
                          height: 50,
                          width: 50,
                          sizeIcon: 40,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resenia.calificador.nombre,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Puntuacion(sizeIcon: 18),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      resenia.comentario,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  child: Text(
                    FormatDate.formatDate(resenia.fecha),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
