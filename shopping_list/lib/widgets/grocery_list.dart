import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  // Luodaan state lista
  final List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'flutter-test-2-e03e7-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');
    final response = await http.get(url);
    final Map<String, Map<String, dynamic>> listData =
        json.decode(response.body);
    for (final item in listData.entries) {
      asd
      // Täällä saadaan map, jossa on GroceryItem tarvittava data
      //GroceryItem(id: id, name: name, quantity: quantity, category: category)
    }
  }

  // Tässä metodissa siirrytään NewItem näkymään
  void _addItem() async {
    //final newItem =
    await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );
    _loadItems();
    // if (newItem == null) {
    //   // Jos ei ole uutta dataa, lopetetaan funktion suoritus
    //   return;
    // }
    // setState(() {
    //   _groceryItems.add(newItem);
    // });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
    // Poiston peruutus
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar on tapa ilmoittaa käyttäjälle viestejä Flutterissa
      // Tässä tapauksessa annetaan ilmoitus ostoksen poistosta ja nappi,
      // jolla ostos voidaan palauttaa.
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text('Your grocery has been deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _groceryItems.add(item);
              });
            }),
      ),
    );
  }

  // 1. Jos lista tyhjä, näyettään jokin muu content näkymässä
  //              Esim: "No groceries added yet. Start adding your groceries!"
  // 2. Tuotteita voi poistaa käyttöliittymässä
  //    Eli niitä voi "pyyhkäistä" pois
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items added yet'),
    );
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
                height: 24,
                width: 24,
                color: _groceryItems[index].category.color),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
          onDismissed: (direction) => _removeItem(_groceryItems[index]),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add_circle_outline),
            )
          ],
        ),
        body: content);
  }
}
