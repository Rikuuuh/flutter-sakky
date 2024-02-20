import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

User? user = FirebaseAuth.instance.currentUser;
String? uid = user!.uid;

// Data rakenne

// Database root
//  - reservations
//    - generated ID (varauksen ID)
//      - datetime: "2024-02-20 12:47:57"
//      - timestamp: 1713613291000 <-- millisekunnit vuodesta 1970-00-00 00:00:00
//        kun aika ilmaistaan integer muodossa, sitä on helpompaa vertailla
//     start: 1713613291000
//      Timestampin pystyy generoimaan datetime muotoon, firebase ymmärtää vain timestamp
//
//      - item_id: 1 (oikeasti firebase generoi)
//      - user_id: "cEWr4lr3GertK4TkrR"
//    - generated ID
//      - datetime: "2024-05-27 12:47:57"
//      - item_id: 2
//      - user_id: "cEh5ghKl5j253mjM"
//  - users
//    - user ID, generated
//      - email: "Jopuu@gmail.com"
//      - name: "Joppe Kala"

// Otetaan yhteys tietokantaan .ref("jokin/polku");
// Polun voi määrittää myöhemmin eri paikkoihin, joten ref on tässä tyhjä
// joka on tietokannan root
final databaseReference = FirebaseDatabase.instance.ref();

class RtTest2Screen extends StatelessWidget {
  const RtTest2Screen({super.key});

  // Tällä funktiolla luodaan varaus tietokantaan
  void _createReservation() async {
    const dateTime = "2024-01-13 12:12:12";
    int timestamp = DateTime.parse(dateTime).millisecondsSinceEpoch;

    // Data joka tallennetaan, JSON objekti.
    final reservation = {
      "user_id": uid,
      "item_id": 3, // Kovakoodataan 1->
      "timestamp": timestamp,
    };
    databaseReference.child('reservations').push().set(reservation);

    // Luetaan data kerran. Löytyy myös keino seurata dataa jos tarvetta
    DatabaseEvent event = await databaseReference.child('reservations').once();
    print('Tietokannan varaukset: ${event.snapshot.value}');
  }

  void _createUser() {
    final user = {
      "name": "testi 1",
      "phone": "0449858",
    };
    databaseReference.child('users/$uid').push().set(user);
  }

  void _logout() async {
    FirebaseAuth.instance.signOut();
  }

  void _queryReservationsByDate() async {
    const startDatetime = '2024-01-11';
    const endDatetime = '2024-01-14';

    int timestampStart = DateTime.parse(startDatetime).millisecondsSinceEpoch;
    int timestampEnd = DateTime.parse(endDatetime).millisecondsSinceEpoch;

    Query query = databaseReference
        .child('reservations')
        .orderByChild('timestamp')
        .startAt(timestampStart)
        .endAt(timestampEnd);
    DatabaseEvent event = await query.once();

    // Huom! Jos halutaan päivittyvä käyttöliittymä, pitää käyttää on() metodia
    // on()-metodi toimii hieman eri tavalla

    print('Alku - loppu : $timestampStart - $timestampEnd');
    print('Varaukset aika välillä : ${event.snapshot.value}');
  }

  void _queryMyReservations() async {
    Query query = databaseReference
        .child('reservations')
        .orderByChild('user_id')
        .equalTo(uid);
    // Jotta query _OIKEASTI_ toimii, tietokannan säännöissä pitää olla index_on määriteltynä

    DatabaseEvent event = await query.once();
    print('Minun varaukset: ${event.snapshot.value}');
    // Oikeasti value:n data leivotaan johonkin malliin (model)
    // Ja modelin perusteella generoidaan wdigettejä käyttöliittymässä
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RealTime Test 2-app'),
        actions: [
          IconButton(
            onPressed: () {
              _logout();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _createReservation,
              child: const Text('Create Reservation!'),
            ),
            ElevatedButton(
              onPressed: _createUser,
              child: const Text('Create User'),
            ),
            ElevatedButton(
              onPressed: _queryMyReservations,
              child: const Text('Check my reservations!'),
            ),
            ElevatedButton(
              onPressed: _queryReservationsByDate,
              child: const Text('Check reservations by date!'),
            ),
          ],
        ),
      ),
    );
  }
}
