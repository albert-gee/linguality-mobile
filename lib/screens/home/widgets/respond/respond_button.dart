import 'package:flutter/material.dart';

class RespondButton extends StatelessWidget {
  const RespondButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}