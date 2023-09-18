import 'package:flutter/material.dart';
import 'package:moni_valinta/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 253, 137),
                Color.fromARGB(255, 4, 40, 102)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const StartScreen(),
        ),
      ),
    );
  }
}
