import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesNotifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => const AddPlaceScreen()),
                ),
              );
            },
            icon: const Icon(
              size: 30,
              Icons.add,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: PlacesList(places: userPlaces),
    );
  }
}
