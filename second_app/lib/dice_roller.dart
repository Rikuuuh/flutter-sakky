import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

// _ <- alaviiva ennen luokan nimeä tekee luokasta "private"
// Tätä luokkaa voi ainoastaan käyttää tässä tiedostossa
class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 3;

  //funktio
  void rollDice() {
    // Määritetään anonyymi funktio
    setState(() {
      // Täällä muokatut luokkamuuttujat, aiheuttavat käyttöliittymän päivityksen
      // Tai ainoastaan tämän luokan päivitksen, joka tarkoittaa build-funktion
      // suorittamista uudelleen.
      currentDiceRoll = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/d$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          // onPressed: () {
          // Tähän tulee koodi
          //},
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // Yksi vaihtoehto erottaa widgettejä
            //padding: const EdgeInsets.only(
            //  top: 20,
            //),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}
