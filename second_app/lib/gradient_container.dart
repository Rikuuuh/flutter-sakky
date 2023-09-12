import 'package:flutter/material.dart';
// import 'package:second_app/styled_text.dart';
import 'package:second_app/dice_roller.dart';

Alignment startAlignment = Alignment.topLeft;

// Muuttujalla täytyy olla arvo, kun se luodaan jos ei erikseen määritellä
// Että se voi olla null. Sen tekee ? muuttujan nimen perässä
// Alignment? startAlignment;

// Vältetään dynaamisia muuttujia
// var thisIsDynamic; <- ei määritellä data tyyppiä / muuttujalle arvoa

// final endAlignment = Alignment.bottomRight;
// final currentDay = getDay(); <- arvo voidaan "suorittaa" funktiosta
// final (runtime) avainsana, muttujan arvo ei ikinä muutu sovelluksen ajon aikana
// final parantaa sovellksen suorituskykyä ja jos muuttujan ei ole tarkoitus
// sovelluksen logiikan perusteella muuttua, se kannattaa määritellä final

const endAlignment = Alignment.bottomCenter;

// const (compile time) toimii samalla tavalla kuin final, mutta sen arvo määritellään
// koodin käännön yhteydessä. Ei tarvitse suorittaa koodia, kun sovellus
// käynnistyy. (Joka määrittää muuttujan arvon)

class GradientContainer extends StatelessWidget {
  // Tätä luokkaa voidaan käyttää monilla eri sivuilla (Modulaarisuus)
  // Koodin pilkkominen pienempiin osiin voi helpottaa sen lukemista
  // const GradientContainer(this.color1, this.color2, {super.key});
  // Properties (fields)
  // final Color color1;
  // final Color color2;

  // Constructor
  // Kytketään propertiesit this. sanalla saman nimiseen muuttujaan
  const GradientContainer({super.key, required this.colors});

  // Harjoitus: muokkaa GradientContainer ottamaan vastaan kaksi väriä
  // Nimetty constructor
  GradientContainer.deepPurple({
    super.key,
  }) : colors = [Colors.deepPurple, const Color.fromARGB(255, 58, 19, 125)];

  // Properties (fields)
  final List<Color> colors;

  //{ const consructorilla ei voi olla body osaa
  // Voi olla myös erillinen koodi body
  // initialization code
  //}

  @override // Kun peritään jokin vaatimus "extends" toiminnalla, käytä tätä
  // Metodi, koska on luokka
  Widget build(context) {
    return Container(
      // Abstract luokka ei voi luoda objectia, siitä vaan peritään asioita
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors, begin: startAlignment, end: endAlignment),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}


// 1. Anonyymi funktio / anonymous function: () {}
// 2. Nimetty funktio