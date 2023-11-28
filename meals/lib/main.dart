import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 141, 61, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main(List<String> args) {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}

// Riverpod
// 1. Luodaan providers tiedostoja, jossa on dataj akeino muokata dataa
// 2. Widgetit ovat "Consumers", jotka käyttävät providerin dataa ja metodeja