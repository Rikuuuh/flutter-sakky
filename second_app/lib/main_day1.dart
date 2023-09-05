import 'package:flutter/material.dart'; // Muista import Flutter

// Koodi rakentuu kahdesta erilaisista "sanoista"
// 1. keywords, ohjelmointi kieli määrittelee
// 2. identifiers, ohjelmoijat määrittelevät

void main() {
  // Määritellään funktio, tämä "main" on dart kielen aloitus piste

  // function body
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'), // Pilkut sulkujen jälkeen!!!
        ),
      ),
    ),
  ); // Suoritetaan flutter frameworkin funktio
} // const, data on immutable

void add({num1, num2}) {
  // Määritellään, named parameters
  num1 + num2; // 5 ja 3
}

void test() {
  add(num1: 5, num2: 3); // Suoritetaan, käytetään named parameters
}
