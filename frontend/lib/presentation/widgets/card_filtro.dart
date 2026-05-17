import 'package:flutter/material.dart';

class CardFiltro extends StatelessWidget {
  const CardFiltro({
    this.paddingHor,
    this.paddingVer,this.heightDynamic = false, 
    this.paddingHorText,
    super.key,
    this.height,
    required this.textoSup,
    required this.textoinF,
  });
  final String textoSup;
  final String textoinF;
  final double? height;
  final double? paddingHor;
  final double? paddingVer;
  final double? paddingHorText;
  final bool? heightDynamic;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: (!heightDynamic! && height != null ) ? 70 : null,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHor ?? 10,
          vertical: paddingVer ?? 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.grey.shade600),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorText ?? 0),
                child: Text(
                  textoSup,
                  style: TextStyle(
                    color: Color(0xFF49454F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (textoinF.isNotEmpty) ...[
                Text(
                  textoinF,
                  style: TextStyle(
                    color: Color(0xFF49454F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
