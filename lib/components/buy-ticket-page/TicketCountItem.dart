import 'package:flutter/material.dart';

class TicketCountItem extends StatelessWidget {
  const TicketCountItem({
    required this.onTap,
    required this.buttonText,
    super.key,
    this.border,
  });

  final VoidCallback onTap;
  final String buttonText;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: border,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [const Icon(Icons.qr_code_2), Text(buttonText)],
          ),
        ),
      ),
    );
  }
}
