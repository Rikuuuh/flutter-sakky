import 'package:chat/screens/rt_test.dart';
import 'package:flutter/material.dart';

// Tämä tiedosto ottaa yhteyden käyttäjän varauksiin (Realtime Database FB)
// Ja näyttää ne käyttäjälle StreamBuilderin avulla
// Päivittyy tietokanan tiedon perusteella automaattisesti

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// Haetaan kirjautuneen käyttäjän uid, tämän id:n perusteella haetaan dataa
final User? user = FirebaseAuth.instance.currentUser;
final String uid = user!.uid; // Tälle sivulle pääsee vain kirjautunut käyttäjä

final databaseReference = FirebaseDatabase.instance.ref();

void _createReservation() async {
  const dateTime = "2024-01-13 12:12:12";
  int timestamp = DateTime.parse(dateTime).millisecondsSinceEpoch;

  // Data joka tallennetaan, JSON objekti.
  final reservation = {
    "user_id": uid,
    "item_id": 5, // Kovakoodattu
    "timestamp": timestamp,
  };
  databaseReference.child('reservations').push().set(reservation);
}

class RtStreamScreen extends StatelessWidget {
  const RtStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StreamBuilder',
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: databaseReference
              .child('reservations')
              // Tässä pitää olla user_id, jos näytetään vain käyttäjän
              .orderByChild('user_id')
              .equalTo(uid) // Haetaan vain käyttäjän varaukset
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.hasData && snapshot.data!.snapshot.value == null) {
              return const Center(
                child: Text('No reservations found'),
              );
            }

            // Tänne päästään kun on dataa!
            // Otetaan data talteen muuttujaan, voi olla myös List<Model>
            // Json data => List<JokinLuokka>
            Map<dynamic, dynamic>? data =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            // data[0].user_id <- ei toimi tässä tilanteessa (ilman model-luokkaa)

            var reservations = <Map<dynamic, dynamic>>[];

            data.forEach((key, value) {
              reservations.add(value);
            });

            reservations.sort(
              (a, b) => a['timestamp'].compareTo(b['timestamp']),
            );
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: reservations.length,
                    padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                    itemBuilder: (context, index) {
                      // Yksi varaus
                      final reservation = reservations[index];
                      return ListTile(
                        title: Text('Timestamp: ${reservation['timestamp']}',
                            style: const TextStyle(fontSize: 13)),
                        subtitle: Text('Item ID: ${reservation['item_id']}',
                            style: const TextStyle(fontSize: 12)),
                        trailing: Text('User ID: ${reservation['user_id']}',
                            style: const TextStyle(fontSize: 12)),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: _createReservation,
                    child: const Text('Create reservation!'))
              ],
            );
          }),
    );
  }
}
