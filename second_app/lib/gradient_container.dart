import 'package:flutter/material.dart';
import 'package:second_app/styled_text.dart';

class GradientContainer extends StatelessWidget {
  // Tätä luokkaa voidaan käyttää monilla eri sivuilla (Modulaarisuus)
  // Koodin pilkkominen pienempiin osiin voi helpottaa sen lukemista

  // Constructor
  const GradientContainer({super.key});
  //{ const consructorilla ei voi olla body osaa
  // Voi olla myös erillinen koodi body
  // initialization code
  //}

  @override // Kun peritään jokin vaatimus "extends" toiminnalla, käytä tätä
  // Metodi, koska on luokka
  Widget build(context) {
    return Container(
      // Abstract luokka ei voi luoda objectia, siitä vaan peritään asioita
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 19, 2, 93),
          Color.fromARGB(255, 199, 128, 5)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: const Center(
        child: StyledText(),
      ),
    );
  }
}
