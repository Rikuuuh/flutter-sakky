import 'package:flutter/material.dart';
import 'package:vko_kaksi/tyyli_text.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [
          Color.fromARGB(187, 255, 145, 0),
          Color.fromARGB(255, 255, 255, 255)
        ]),
      ),
      margin: const EdgeInsets.all(100.0),
      padding: const EdgeInsets.all(20.0),
      child: const Center(child: TyyliText()),
    );
  }
}
