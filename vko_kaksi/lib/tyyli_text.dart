import 'package:flutter/material.dart';

class TyyliText extends StatelessWidget {
  const TyyliText({super.key});

  @override
  Widget build(context) {
    return const Text('Appi',
        style: TextStyle(
            fontSize: 33,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0)));
  }
}
