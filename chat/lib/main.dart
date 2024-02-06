import 'package:chat/screens/auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 151, 118, 207),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
