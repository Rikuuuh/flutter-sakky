import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorSchema = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 99, 9, 245),
  background: const Color.fromARGB(255, 49, 59, 45),
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorSchema.background,
  colorScheme: colorSchema,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

// Model luokalle "Place", jossa property title
// Riverpod, jossa dynaaminen Places lista
// Sivu, joka generoi riverpod datan sisällön
// Sivu, jossa lisätään objekteja riverpod dataan
// Klikataan jotain Places objektia,
// näytetään uusi sivu: places_details == Näytetään titlen tektsti

// 1kpl model, 1kpl riverpod provider, 3kpl screen widgets, ? kpl widgetejä
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Places',
      theme: theme,
      home: ListView.builder(itemBuilder: (context, index) => ,),
    );
  }
}
