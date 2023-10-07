import 'package:flutter/material.dart';
import 'package:elokuva/pick_screen.dart';
import 'package:elokuva/result_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const PickScreen(),
        '/result': (context) => const ResultsScreen(),
      },
    );
  }
}
