import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryListFuture extends StatefulWidget {
  const GroceryListFuture({super.key});

  @override
  State<GroceryListFuture> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryListFuture> {
  // Luodaan state lista
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error = null;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'flutter-test-2-e03e7-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');
    // get,post,delete jne heittää tälläisen virheen joissain tilanteissa
    // meidän pitää koodissa hallita se virhe : try{}catch(){}
    //throw Exception('An error occurred!');
    try {
      final response = await http.get(url);

      // Jos statuscode on 400 tai enemmän, on tapahtunut virhe
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'failed to fetch data. Please try again later!';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
          return;
        });
      }
      // Kaatuu, jos body == null
      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (element) => element.value.title == item.value['category'])
            .value;
        // Täällä saadaan map, jossa on GroceryItem tarvittava data
        loadedItems.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category));
      }
      // Odottaa 4 sekunttia että käynnistää loadin. (Spinneriä varten used)
      // await Future.delayed(const Duration(seconds: 4));
      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong! $error';
      });
    }
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
    final index = _groceryItems.indexOf(item);
    // Oletuksena poistetaan tuote
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https(
        'flutter-test-2-e03e7-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list/${item.id}.json');
    try {
      final response = await http.delete(url);

      // Palautetaan tuote, jos poisto epäonnistui
      if (response.statusCode >= 400) {
        setState(() {
          // Plautetaan takaisin vanhaan indeksiin
          _groceryItems.insert(index, item);
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 4),
            content: Text('Removing your grocery didnt work, try again later'),
          ),
        );
      }
    } catch (error) {
      setState(() {
        _error = 'Something went wrong! $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items added yet'),
    );

    if (_isLoading == true) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
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
    if (_error != null) {
      Center(
        child: Text(_error!),
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
