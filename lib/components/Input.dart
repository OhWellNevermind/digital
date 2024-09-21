import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    required this.label,
    required this.controller,
    this.isObscure = false,
    this.margin,
    super.key,
  });

  final String label;
  final bool isObscure;
  final EdgeInsetsGeometry? margin;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        child: SizedBox(
          width: 250,
          child: TextField(
            controller: controller,
            obscureText: isObscure,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
            ),
          ),
        ));
  }
}
