import 'package:flutter/material.dart';

class FormTextInput extends StatelessWidget {
  const FormTextInput({
    super.key,
    this.validator,
    this.labelText,
    this.isObscure = false,
  });

  final String? Function(String?)? validator;
  final String? labelText;

  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: isObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        labelText: labelText,
      ),
    );
  }
}
