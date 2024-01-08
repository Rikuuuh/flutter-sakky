import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
// Tämä widget näkyy screen/places.dart tiedostossa

// Widget saa parametrina listan place objekteja
// ja palauttaa ne ListView.builder rakenteessa

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'Start adding your places',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: places.length,
      itemBuilder: (context, index) => ListTile(
        tileColor: Colors.black12,
        title: Text(
          places[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
