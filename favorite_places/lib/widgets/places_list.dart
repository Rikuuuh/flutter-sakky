import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_details.dart';
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
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailsScreen(
                  places[index],
                ),
              ),
            );
          },
          tileColor: Colors.black45,
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: FileImage(
              places[index].image,
            ),
          ),
        ),
      ),
    );
  }
}
