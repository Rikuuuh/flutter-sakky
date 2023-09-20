import 'package:flutter/material.dart';
import 'package:koti_teht/mc_screen.dart';
import 'package:koti_teht/hs_screen.dart';
import 'package:koti_teht/bk_screen.dart';
import 'package:koti_teht/start_screen.dart';

class Parent extends StatefulWidget {
  const Parent({super.key});

  @override
  State<Parent> createState() {
    return _ParentState();
  }
}

class _ParentState extends State<Parent> {
  var activeScreen = "start-screen";

  void startMc() {
    setState(() {
      activeScreen = 'mc-screen';
    });
  }

  void startHs() {
    setState(() {
      activeScreen = 'hs-screen';
    });
  }

  void startBk() {
    setState(() {
      activeScreen = 'bk-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(startMc, startBk, startHs);

    if (activeScreen == 'start-screen') {
      screenWidget = StartScreen(startMc, startBk, startHs);
    } else if (activeScreen == 'mc-screen') {
      screenWidget = McScreen(startMc, startBk, startHs);
    } else if (activeScreen == 'hs-screen') {
      screenWidget = HsScreen(startMc, startBk, startHs);
    } else if (activeScreen == 'bk-screen') {
      screenWidget = BkScreen(startMc, startBk, startHs);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 255, 220, 220),
                Color.fromARGB(255, 0, 42, 54)
              ],
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
