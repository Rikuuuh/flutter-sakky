import 'package:flutter/material.dart';
import 'package:moni_valinta/question_screen.dart';
import 'package:moni_valinta/data/questions.dart';
import 'package:moni_valinta/start_screen.dart';
import 'package:moni_valinta/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  // Määritellään muuttujan datatyypiksi ! WIDGET !,
  // koska molemmat luokat perivät sen

  // - Versio 1 - Widget? activeScreen;

  // Käytetään Widgettien funktiota, joka suoritetaan kun objekti on luotu
  // - Versio 1 - @override
  // void initState() {
  //  super.initState(); // Tämä tapahtuu ekana
  // Koska initState tapahtuu ennen build funktiota, ei tarvita setState
  //  activeScreen = StartScreen(switchScreen);
  // }
  // ctrl + k + c = kommentit

  // - Versio 2 -

  final List<String> selectedAnswers = []; // State
  var activeScreen = 'start-screen'; // Ei tarvitse null arvoa

  // Funktio
  void switchScreen() {
    // setState suorittaa build function uudestaan ja UI voi päivittyä
    setState(
      () {
        // activeScreen = const QuestionScreen(); - Versio 1 -
        activeScreen = 'question-screen';
      },
    );
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        // selectedAnswers.clear();
        activeScreen = 'result-screen';
      });
    }
  }

  // Ensin tallennettiin koko widgetti muuttujaan (pointer objektiin)
  // Nyt tallennetaan jokin oma nimi / arvo, jonka perusteella dynaamisesti
  // tai ehdollisesti rakennetaan build:n sisällä haluttu widget

  @override
  Widget build(context) {
    // Tässä välissä voi suorittaa koodia
    // Tässä ratkaistaan mikä sivu näytetään

    // Build funktion sisällä, ei ole ongelmaa käyttää switchScreen parametriä
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 'result-screen') {
      screenWidget = ResultsScreen(chosenAnswers: selectedAnswers);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 252, 96),
                Color.fromARGB(255, 0, 51, 139)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: screenWidget,
          // ternary expression, ! toimii kuin if else !
          // child: activeScreen == 'start-screen' // Vertailu, antaa true / false
          //     ? StartScreen(switchScreen) // ? on true
          //     : const QuestionScreen(), // : on false
        ),
      ),
    );
  }
}
