import 'package:flutter/material.dart';
class CardOpcion extends StatelessWidget {
  final String title;
  final Icon icon;
  final String subtitle;
  final bool grid;
  final bool editable;
  final bool useIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  const CardOpcion({super.key, 
    this.grid = false,
    this.useIcon = true,
    this.editable = false,
    required this.title,
    required this.icon,
    required this.subtitle,
    this.validator,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: grid ? 2 : null,
      child: TextFormField(
        controller: editable ? controller : null,
        validator: editable ? validator : null,
        ignorePointers: !editable,
        readOnly: !editable,
        decoration: InputDecoration(
          suffixIcon: ((editable || grid) && useIcon)
              ? Icon(Icons.edit_outlined)
              : null,
          prefixIconConstraints: BoxConstraints(minWidth: grid ? 20 : 40),
          label: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black38, fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: grid ? 13 : 14.5,
                ),
              ),
            ],
          ),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: grid ? null : icon,
        ),
      ),
    );
  }
}