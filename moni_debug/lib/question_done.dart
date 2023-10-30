import 'package:flutter/material.dart';

class QuestionDone extends StatelessWidget {
  const QuestionDone({super.key, required this.onDone});

  final Function(BuildContext) onDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "You have answered all the questions, go see your results!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        TextButton.icon(
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 18,
              )),
          onPressed: onDone(context),
          icon: const Icon(Icons.double_arrow_rounded),
          label: const Text('See results of your Quiz!'),
        ),
      ],
    );
  }
}
