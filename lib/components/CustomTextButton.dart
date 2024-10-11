import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.buttonText,
    super.key,
    this.onTap,
    this.bgColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.textColor = Colors.black,
  });

  final String buttonText;
  final VoidCallback? onTap;
  final Color? bgColor;
  final EdgeInsets padding;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: bgColor,
        padding: padding,
        textStyle: TextStyle(
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: Text(buttonText),
    );
  }
}