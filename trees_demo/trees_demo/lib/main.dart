import 'package:flutter/material.dart';
import 'package:trees_demo/keys.dart';
// import 'package:trees_demo/ui_updates_demo.dart';

void main() {
  // Mutable / Immutable : muokattavissa / eimuokattavissa
  final numbers = [1, 2, 3]; // numbers muuttuja on final, ei voi muokata
  // Mutta itse lista on erillinen asia muistissa, jota voi edelleen muokata

  // var numbers = [1,2,3]; Nyt voi muokata osoitetta

  // const numbers = [1, 2, 3]; // sekä osoite ja listan sisältö on lukittu

  // const vuoksi, widgettejä voidaan uudelleen käyttää, koska ne eivät voi muuttua

  // numbers = [4, 5, 6]; Luodaan uusi lista objekti ja yritetään tallentaa sen osoite
  // ei toimi jos final

  numbers.add(4);

  var nums = [1, 2]; // -> 0x21d36e0 List(1, 2)

  nums = [3, 4]; // -> 0x53e44c1 List(3, 4)

  // 0x21d36e0 osoitteeseen ei enää viitata ja roskien keru vapauttaa muistin

  nums.add(5); // -> 0x53e44c1 List(3, 4, 5)

  // Kuinka laitteet käyttävät RAM muistia
  // jokaisella sovelluksella on oma stack ja heap. Jos multithreaded jokaisella
  // ytimellä / säikeellä on oma stack, mutta jaettu heap.
  // stack -> pino, tietty koko, tietty järjestys, nopeampi kuin heap
  // heap -> keko, läjä, asiat on satunnaisessa kasassa

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Internals'),
        ),
        body: const Keys(),
      ),
    );
  }
}

// Flutterissa on kolme "puuta"
// 1. Widget Tree - Meidan koodi, koostuu käyttöliittymän
// 2. Element Tree - Flutter automaattisesti taustalla rakentaa muistiin
//           elementin jokaista widget-objektia. Elementissä on viittaus
//           (referenssi) käytettävissä olevaan widget objektiin
//           Flutter käyttää tätä määrittelemään onko tarvetta päivittää UI.
// 3. Render Tree - Näkyvät käyttöliittymän osat. Flutter välttää käyttöliittymän
//           uudelleen generointia mahdollisimman paljon. Widget <--> Element vertailu
//           käynnistää käyttöliittymän päivityksen. Päivittää vain tarvittavat osat.

//  1                        build()
//  2      New Expected UI    <-->    Actual UI
//  3             UI gets updated as needed

// build()                        luodaan kerran build()
//                                käytetään uudelleen
// Widget Tree                    element Tree
// Column()                     <-       Column element
//  (key A)ItemWidget A         <-        (Key A)ItemWidget element  -> State A
//  (key B)ItemWidget B         <-        (Key B)ItemWidget element  -> State B
//  (key C)ItemWidget C         <-        (Key C)ItemWidget element  -> State C