import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/user_places.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();

  void _savePlace() {
    final enteredText = _titleController.text;

    if (enteredText.trim().isEmpty) {
      // Ei tehdä tallennusta, lopetetaan metodin suoritus
      return;
    }

    // Täällä tehdään tallennus provideriin
    // Ensin provider viittaus ja ConsumerStatefulWidget!

    // Käytetään read tallennus tilanteessa
    ref.read(userPlacesNotifier.notifier).addPlace(enteredText);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground)),
              controller: _titleController,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blueGrey[200]),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.all(12),
                ),
              ),
              icon: const Icon(Icons.add),
              onPressed: _savePlace,
              label: const Text(
                'Add Place',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
