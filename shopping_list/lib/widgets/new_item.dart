// Tässä tiedostossa on form, jolla käyttäjä voi lisätä
// uusia tuotteita ostoslistaansa

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = '';

  void _saveItem() {
    // Suoritetaan kaikki validoinnit
    if (_formKey.currentState!.validate() == true) {
      _formKey.currentState!.save();
      Navigator.pop(context);
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
                      initialValue: '1',
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
                        _enteredQuantity = newValue!;
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
                      onChanged: (value) => {},
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
