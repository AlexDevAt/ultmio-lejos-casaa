import 'package:flutter/material.dart';

class BarraBusqueda extends StatelessWidget {
  final FormFieldValidator<String> validacion;
  final TextEditingController controller;
  final VoidCallback onPress;
  final Color? colorBackGround;
  final String text;
  final double? padingHor;
  final double? padingVer;
  final Color? colorBorder;
  final double? borderSize;
  final double? iconSize;
  final bool prefixIcon;

  const BarraBusqueda( {
    super.key,
    this.prefixIcon = false,
    this.iconSize,
    this.colorBackGround,
    this.colorBorder,
    this.borderSize,
    this.padingHor,
    this.padingVer,
    required this.validacion,
    required this.controller,
    required this.onPress,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padingHor ?? 40,
        vertical: padingVer ?? 0,
      ),
      child: TextFormField(
        controller: controller,
        validator: validacion,
        decoration: InputDecoration(
          prefixIcon: prefixIcon
              ? IconButton(onPressed: onPress, icon: Icon(Icons.search,size: iconSize ?? 24,))
              : null,
          suffixIcon: !prefixIcon
              ? IconButton(onPressed: onPress, icon: Icon(Icons.search))
              : null,
          filled: true,

          hintText: text,
          fillColor: colorBackGround ?? Colors.grey.shade300,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderSize ?? 12),
            borderSide: BorderSide(color: colorBorder ?? Colors.transparent),
          ),
        ),
      ),
    );
  }
}
