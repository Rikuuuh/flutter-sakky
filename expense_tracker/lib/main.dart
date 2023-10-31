import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 137, 64, 255));

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          shadowColor: kDarkColorScheme.secondary,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 18,
              ),
              titleMedium:
                  TextStyle(color: kDarkColorScheme.onSecondaryContainer),
              bodyMedium:
                  TextStyle(color: kDarkColorScheme.onSecondaryContainer),
              bodyLarge:
                  TextStyle(color: kDarkColorScheme.onSecondaryContainer),
            ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 1, 40, 51),
        iconTheme: const IconThemeData()
            .copyWith(color: kDarkColorScheme.onPrimaryContainer),
        canvasColor: kDarkColorScheme.secondaryContainer,
        inputDecorationTheme: InputDecorationTheme(
          prefixStyle: TextStyle(color: kDarkColorScheme.onSecondaryContainer),
          suffixStyle: TextStyle(color: kDarkColorScheme.onSecondaryContainer),
        ),
      ),

      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          // copyWith, säilyttää oletus arvot ja
          // korvataan vain täällä määritetyt asiat
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          shadowColor: kColorScheme.secondary,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 17,
              ),
            ),
      ),
      // themeMode: ThemeMode.system, // oletus asetus on system
      home: const Expenses(),
    ),
  );
}
