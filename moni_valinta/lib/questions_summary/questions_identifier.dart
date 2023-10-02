import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier(
      {super.key, required this.isCorrectAnswer, required this.questionIndex});

  final int questionIndex;
  final bool isCorrectAnswer;

  @override
  Widget build(BuildContext context) {
    final questionNumber = questionIndex + 1;
    Color rightColor = Colors.greenAccent;
    Color wrongColor = Colors.redAccent;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isCorrectAnswer ? rightColor : wrongColor,
      ),
      child: Center(
        child: Text(
          questionNumber.toString(),
          style: GoogleFonts.saira(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            // backgroundColor: isCorrectAnswer ? rightColor : wrongColor,
          ),
        ),
      ),
    );
  }
}
