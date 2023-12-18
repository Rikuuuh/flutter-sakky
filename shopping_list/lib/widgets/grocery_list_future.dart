import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

// onko järkevä esim jos pelistä saa tuloksia ja kun on pelannut pelin läpi
// niin näkee vaikka results kohdan ja kaikkien muiden tulokset ja oman tuloksen
// että monenneksiko on tullut (mökkiolympialais app)
class GroceryListFuture extends StatefulWidget {
  const GroceryListFuture({super.key});

  @override
  State<GroceryListFuture> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryListFuture> {
  // Luodaan state lista
  final List<GroceryItem> _groceryItems = [];
  // Muuttuja, jossa on tietokannasta haetut tavarat
  late Future<List<GroceryItem>> _loadedItems;
  // late, luvataan kääntäjälle, että ladataan muuttujaan data, ennen kuin sitä
  // käytetään build funktiossa.
  // Widget elinkaaressa initState() -> build()

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  // Koska metodi on async, se palauttaa datan future muodossa
  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        'flutter-test-2-e03e7-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      // Heitetään virhe, joka käsitellään FutureBuilder snapshot:issa
      throw Exception('Failed to fetch items!');
    }

    var testForNull = json.decode(response.body);

    if (testForNull == null) {
      // Pakko määrittää palautettava datarakenne, koska metodilla on palautusarvo
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value['category'])
          .value;
      loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
    }
    return loadedItems;
  }

  // Tässä metodissa siirrytään NewItem näkymään
  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );
    if (newItem == null) {
      // Jos ei ole uutta dataa, lopetetaan funktion suoritus
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    _groceryItems.indexOf(item);
    // Oletuksena poistetaan tuote
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
          future: _loadedItems,
          builder: (context, snapshot) {
            // Täällä snapshotin tilanteen perusteella
            // generoidaan eri widget rakenne

            // Snapshot odottaa dataa = näytetään spinneri
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // Virhetilanne
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            // Tyhjä lista, data on haettu ja siinä on tyhjä lista
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No items added yet'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(snapshot.data![index].id),
                child: ListTile(
                  title: Text(snapshot.data![index].name),
                  leading: Container(
                      height: 24,
                      width: 24,
                      color: snapshot.data![index].category.color),
                  trailing: Text(snapshot.data![index].quantity.toString()),
                ),
                onDismissed: (direction) => _removeItem(snapshot.data![index]),
              ),
            );
          }),
      // Tässä suoritetaan _loadItems() metodi, joka palauttaa futuurin
      // Nyt tieto haetaan tietokannasta, joka kerta kun build suoritetaan
      // Joka aiheuttaa turhaa tietokanta kutsua
      // FutureBuilder(future: _loadItems(), builder: (context, snapshot) {}),
    );
  }
}
