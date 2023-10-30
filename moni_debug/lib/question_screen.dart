// Luo stateful widget, joka palauttaa Text widgetin tekstillä "Question Screen"

import 'package:flutter/material.dart';
import 'package:moni_debug/data/questions.dart';
import 'package:moni_debug/question_normal.dart';
import 'package:moni_debug/question_done.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.onSelectAnswer,
    required this.currentIndex,
    required this.onRestart,
    required this.onDone,
  });

  final void Function(String answer, BuildContext) onSelectAnswer;
  final void Function(BuildContext) onDone;

  final Function(int, BuildContext) onRestart;
  final int currentIndex;

  // createState
  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

// Luokan nimessä on alaviiva, joten se on yksityinen
// Yksityistä luokkaa voi käyttää vain tämän tiedoston sisäiset koodit
class _QuestionScreenState extends State<QuestionScreen> {
  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer, context);
  }

  // build
  @override
  Widget build(context) {
    Widget viewWidget = QuestionDone(onDone: widget.onDone);
    if (widget.currentIndex < questions.length) {
      final currentQuestion = questions[widget.currentIndex];
      viewWidget = QuestionNormal(currentQuestion, answerQuestion);
    }
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: viewWidget,
      ),
    );
  }
}
