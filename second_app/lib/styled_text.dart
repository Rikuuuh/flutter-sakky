import 'package:flutter/material.dart';

// immutable = asiaa ei voi muokata
class StyledText extends StatelessWidget {
  // Constructor
  const StyledText(this.text, {super.key}) : num = 5;

  const StyledText.hello(this.num, {super.key}) : text = 'hello';

  final String text;
  final int num;

  // Metodi (funktio)
  @override
  Widget build(context) {
    return Text(
      text + num.toString(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
