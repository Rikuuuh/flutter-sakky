import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/question.png',
            width: 150,
            color: const Color.fromARGB(115, 255, 253, 137),
          ),
          const SizedBox(height: 40),
          Text(
            'Start Screen',
            style: GoogleFonts.sansita(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt_sharp),
            label: Text(
              'Start Quiz',
              style: GoogleFonts.sansita(
                fontSize: 17.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
