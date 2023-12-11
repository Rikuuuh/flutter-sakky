// Tässä tiedostossa on form, jolla käyttäjä voi lisätä
// uusia tuotteita ostoslistaansa

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  var _enteredName = '';
  var _enteredQuantity = 1;
  // ignore: prefer_final_fields
  var _selectedCategory = categories[Categories.vegetables]!;

  void _saveItem() async {
    // Suoritetaan kaikki validoinnit
    if (_formKey.currentState!.validate() == true) {
      _formKey.currentState!.save();
      final url = Uri.https(
          'flutter-test-2-e03e7-default-rtdb.europe-west1.firebasedatabase.app',
          'shopping-list.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': _enteredName,
            'quantity': _enteredQuantity,
            'category': _selectedCategory.title,
          },
        ),
      ); //.then((value) => null)

      print(response.statusCode);
      print(response.body);

      if (!context.mounted) {
        // Lopetetaan suoritus, jos contextin widget ei ole enää aktiivinen
        return;
      }
      Navigator.of(context).pop();

      //Navigator.of(context).pop(
      // Luodaan uusi GroceryItem objekti johon tallennetaan formilta saadut
      // muuttujat ja viedään pop mukana GroceryList näkymään
      //GroceryItem(
      //id: DateTime.now().toString(), // Placeholder id
      //name: _enteredName,
      //quantity: _enteredQuantity,
      //category: _selectedCategory,
      //),
      //);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey, // Avaimen perusteella suoritetaan operaatioita
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                // value on data inputissa
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return "Must be between 2 and 50"; // == Virhe
                  }
                  return null; // == Ei ole virhettä
                },
                onSaved: (newValue) {
                  _enteredName = newValue!;
                  // Ei tarvita setState
                  // _enteredQuantity muuttujan arvoa ei näy käyttäjille
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: _enteredQuantity.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) ==
                                null || // null == parse epäonnistui
                            int.tryParse(value)! <= 0) {
                          return "Must be a valid, positive number"; // == Virhe
                        }
                        return null; // == Ei ole virhettä
                      },
                      onSaved: (newValue) {
                        // Suoritetaan validator ensin, joten
                        // value ei voi olla null
                        _enteredQuantity = int.parse(newValue!);

                        // Ei tarvita setState
                        // _enteredQuantity muuttujan arvoa ei näy käyttäjille
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        // For silmukka listan sisällä
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.title)
                              ],
                            ),
                          ),
                      ],
                      onChanged: (data) {
                        _selectedCategory = data!;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      icon: const Icon(Icons.restore),
                      label: const Text('Reset')),
                  const Spacer(),
                  ElevatedButton.icon(
                      onPressed: _saveItem,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Item'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
