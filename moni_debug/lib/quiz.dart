import 'package:flutter/material.dart';
import 'package:moni_debug/data/questions.dart';
import 'package:moni_debug/question_screen.dart';
import 'package:moni_debug/results_screen.dart';
import 'package:moni_debug/start_screen.dart';

// Widget
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = []; // State
  int currentQuestionIndex = 0;

  // funktio
  void switchScreen(int value, BuildContext ctx) {
    setState(
      () {
        currentQuestionIndex = 0;
        selectedAnswers.clear();
        final TabController tabController = DefaultTabController.of(ctx);
        tabController.animateTo(1);
      },
    );
  }

  void chooseAnswer(String answer, BuildContext ctx) {
    setState(() {
      currentQuestionIndex++;
    });
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      final TabController tabController = DefaultTabController.of(ctx);
      tabController.animateTo(2);
    }
  }

  void restartQuiz(int value, BuildContext ctx) {
    setState(() {
      selectedAnswers.clear();
      currentQuestionIndex = 0;
      final TabController tabController = DefaultTabController.of(ctx);
      tabController.animateTo(1);
    });
  }

  void resultQuiz(BuildContext ctx) {
    setState(() {
      final TabController tabController = DefaultTabController.of(ctx);
      tabController.animateTo(2);
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Builder(builder: (BuildContext innerContext) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text('Tabs testi'),
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ]),
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 98, 184, 36),
                    Color.fromARGB(255, 142, 249, 110)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: TabBarView(children: [
                StartScreen(switchScreen),
                QuestionScreen(
                  currentIndex: currentQuestionIndex,
                  onSelectAnswer: chooseAnswer,
                  onRestart: restartQuiz,
                  onDone: resultQuiz,
                ),
                ResultsScreen(
                    chosenAnswers: selectedAnswers, onRestart: restartQuiz)
              ]),
            ),
          );
        }),
      ),
    );
  }
}
