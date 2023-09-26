import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moni_valinta/data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers});

  final List<String> chosenAnswers;

  // Map on datarakenne, jossa voidaan määritellä key: value pareja
  // Esim ikä(key): 33(value)
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = []; // Luodaan lista

    // Generoidaan data...
    for (var i = 0; i < chosenAnswers.length; i++) {
      // For loop body
      summary.add({
        //key: value
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers.first,
        'user_answer': chosenAnswers[i],
      });
    }

    return summary; // Palautetaan lista
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered X out of Y questions correctly!',
              style: GoogleFonts.sansita(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'List of answers and questions here...',
              style: GoogleFonts.sansita(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Restart Quiz!',
                style: GoogleFonts.sansita(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
