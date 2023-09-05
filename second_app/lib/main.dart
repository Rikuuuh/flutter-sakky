import 'package:flutter/material.dart';
import 'package:second_app/gradient_container.dart';

// 1. Dart projekti alkaa lib/main.dart tiedostosta
// 2. Suoritus alkaa main-funktiosta. Lisää tähän tiedostoon main funktio.
// 3. Flutter käynnistyy runApp-funktiosta. Lisää se funktio.
// 4. Flutter käyttää Material Design UI-kirjastoa, lisää sen widget. SCAFFOLD
// 5. Käyttöliittymä rakennus alkaa jostakin widgetistä, lisää se widget
// 6. Lisää tekstiä, joka on keskitetty.

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(),
      ),
    ),
  );
}

// Ctrl + Välilyönti jotta näkee valmiit vaihtoehdot koodista
// Flutter on "type-safe" kieli. type, tarkoittaa data tyyppiä.
// Data           -> Data tyypin nimi
// 'Hello world!' -> string / Object
// 29             -> int / num / Object
// MaterialApp    -> MaterialApp / Widget / Object
// OmaLuokkaWidget-> OmaLuokkaWidget / Widget / Object

// Luokilla voi tehdä omia datarakenteita tai datatyyppejä

// Luokka on kokoelma 1. dataa ja 2. toiminnallisuutta
// 1. data on muuttujia / variables / properties(luokka)
// 2. toiminnallisuus on funktio / function / method(luokka)
// 3. rakentaja funktio / constructor, voidaan määrittää koodia, joka
//    suoritetaan kun luokasta luodaan oliota / objektia

