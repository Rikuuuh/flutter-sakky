import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moni_valinta/data/questions.dart';
import 'package:moni_valinta/questions_summary/questions_summary.dart';

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
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where(
      (elementData) {
        // Where funktion sisällä pitää suorittaa funktio joka palauttaa
        // true tai false. true säilyttää datan ja false hylkää datan.
        // Where suodattaa alkuperäisen listan dataa ja palauttaa uuden
        // suodatetun listan.
        return elementData['user_answer'] == elementData['correct_answer'];
      },
    ).length;

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
              height: 30,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Restart Quiz!',
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
