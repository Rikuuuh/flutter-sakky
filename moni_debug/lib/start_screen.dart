import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  // Constructor
  const StartScreen(this.startQuiz, {super.key});

  // luokkamuuttuja / property
  final Function(int, BuildContext) startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ), ctrl + k + c -> ctrl + k + u poistaa kommentit
          Image.asset(
            'assets/images/question.png',
            width: 150,
            color: const Color.fromARGB(144, 255, 255, 255),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Start Screen',
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            onPressed: () => startQuiz(0, context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}