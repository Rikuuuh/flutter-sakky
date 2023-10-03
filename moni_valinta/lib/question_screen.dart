import 'package:flutter/material.dart';
import 'package:moni_valinta/data/questions.dart';
import 'package:moni_valinta/answer_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      // currentQuestionIndex = currentQuestionIndex + 1;
      // currentQuestionIndex += 1;
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Center(
      child: Container(
        margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.saira(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              // Stylen ulkopuolelle jos ei mee keskelle!
            ),
            const SizedBox(
              height: 40,
            ),
            // Map funktio käy läpi datan listassa, suorittaa funktion jokaista
            // listan itemiä kohden ja tallentaa uuden datan, uuteen listaan.
            // Uusi lista ei näy koodissa, se vain ilmestyy tähän kohtaan, jossa
            // suoritetaan map() funktio

            // Spread operaatio käyttämällä ... map- funktion kanssa
            ...currentQuestion.getShuffledAnswers().map(
              (item) {
                return AnswerButton(
                  answerText: item,
                  onTap: () {
                    answerQuestion(item);
                  },
                );
              },
            ),

            //AnswerButton(answerText: currentQuestion.answers[0], onTap: () {}),
            //AnswerButton(answerText: currentQuestion.answers[1], onTap: () {}),
            //AnswerButton(answerText: currentQuestion.answers[2], onTap: () {}),
            //AnswerButton(answerText: currentQuestion.answers[3], onTap: () {}),
          ],
        ),
      ),
    );
  }
}
