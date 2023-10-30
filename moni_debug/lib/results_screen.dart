import 'package:flutter/material.dart';

import 'package:moni_debug/data/questions.dart';
import 'package:moni_debug/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.onRestart});

  final List<String> chosenAnswers;
  final Function(int, BuildContext) onRestart;

  // Map on datarakenne, jossa voidaan määritellä key: value pareja.
  // Esim ikä(key): 33(value)
  // List<Map<String, Object>> getSummaryData() {
  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = []; // Luodaan lista

    // Generoidaan data... 0 1 2 3 4 5 <- nuo i arvot suoritetaan
    for (var i = 0; i < chosenAnswers.length; i++) {
      // For Loop Body
      summary.add({
        // key: value
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0], // Magic Number
        'user_answer': chosenAnswers[i]
      });
    }

    return summary; // Palautetaan lista
  }

  @override
  Widget build(BuildContext context) {
    // Luodaan muuttujat, jossa on kaikkien kysymyksien lukumäärä ja
    // oikeiden vastauksien lukumäärä.
    final numCorrectQuestions = summaryData
        .where(
          (elementData) =>
              elementData['user_answer'] == elementData['correct_answer'],
        )
        .toList();

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'You answered ${numCorrectQuestions.length} out of ${chosenAnswers.length} questions correctly!'),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(
              summaryData,
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () => onRestart(1, context),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
