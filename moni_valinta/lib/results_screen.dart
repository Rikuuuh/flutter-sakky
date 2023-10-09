import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moni_valinta/data/questions.dart';
import 'package:moni_valinta/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.onRestart});

  final List<String> chosenAnswers;
  final void Function() onRestart;

  // Map on datarakenne, jossa voidaan määritellä key: value pareja
  // Esim ikä(key): 33(value)

  // List<Map<String, Object>> getSummaryData() {
  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = []; // Luodaan lista

    // Generoidaan data...
    for (var i = 0; i < chosenAnswers.length; i++) {
      // For loop body
      summary.add({
        //key: value
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary; // Palautetaan lista
  }

  @override
  Widget build(BuildContext context) {
    // Luodaan muuttujat, jossa on kaikkien kysymyksien lukumäärä ja
    // oikeiden vastauksien lukumäärä.

    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where(
          (elementData) =>
              elementData['user_answer'] == elementData['correct_answer'],
          // Where funktion sisällä pitää suorittaa funktio joka palauttaa
          // true tai false. true säilyttää datan ja false hylkää datan.
          // Where suodattaa alkuperäisen listan dataa ja palauttaa uuden
          // suodatetun listan.
        )
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.saira(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            QuestionsSummary(
              summaryData,
            ),
            const SizedBox(
              height: 35,
            ),
            TextButton.icon(
              onPressed: onRestart,
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ),
              label: Text(
                'Restart Quiz',
                style: GoogleFonts.saira(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
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
