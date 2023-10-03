// Tässä tiedostossa yksi rivi tuloksia.
// Käytetään questions_identifier widgettiä ja sarakkeessa kysymys, vastaus ja
// oikea vastaus
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moni_valinta/questions_summary/questions_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    const Color rightColor = Colors.greenAccent;
    const Color wrongColor = Colors.redAccent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIdentifier(
          isCorrectAnswer: isCorrectAnswer,
          questionIndex: itemData['question_index'] as int,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemData['question'] as String,
                style: GoogleFonts.saira(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if (isCorrectAnswer)
                const Icon(
                  Icons.thumb_up_alt_sharp,
                  color: Colors.greenAccent,
                  size: 14,
                )
              else
                const Icon(
                  Icons.thumb_down_alt_sharp,
                  color: Colors.redAccent,
                  size: 14,
                ),
              Text(
                itemData['user_answer'] as String,
                style: GoogleFonts.saira(
                  fontSize: 14,
                  color: isCorrectAnswer ? rightColor : wrongColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      itemData['user_answer'] as String,
                      style: GoogleFonts.saira(
                        fontSize: 14,
                        color: isCorrectAnswer ? rightColor : wrongColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
