import 'package:flutter/material.dart';

// immutable = asiaa ei voi muokata
class StyledText extends StatelessWidget {
  const StyledText(this.text, {super.key});

  // Luokkamuuttuja / property
  final String text;

  // Metodi (funktio)
  @override
  Widget build(context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 33,
      ),
    );
  }
}
