import 'package:flutter/material.dart';
import 'package:elokuva/model/leffa_question.dart';
import 'package:elokuva/answer_button.dart';

class PickScreen extends StatelessWidget {
  const PickScreen({super.key});
  final question = const LeffaQuestion(
    'Minkä elokuvan haluat katsoa?',
    ['Action', 'Drama', 'Comedy', 'Horror'],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question.text,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ...question.answers.map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/result',
                    arguments: answer,
                  );
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
