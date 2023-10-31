import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';
  // void _saveTitleInput(String inputValue) {
  // _enteredTitle = inputValue;
  // }

  // Flutterin objecti, suorittaa käyttäjän syöttämän tekstin tallennuksen
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  DateTime? // <--- ? = Voi olla null
      _selectedDate; // Voi olla null, koodissa pitää varmistaa ettei sovellus kaadu

  Category _selectedCategory = Category.theater;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year, now.month + 1, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate); // .then((value) => null); // Yksi vaihtoehto
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final double? enteredPrice = double.tryParse(_priceController.text);

    // ==, >=, <: ovat vertailu operaatioita
    // || ja && ovat loogisia operaatioita, joilla voi yhdistää useamman vertailun
    final bool priceIsInvalid = enteredPrice == null || enteredPrice < 0;

    // Tarkistetaan käyttäjän tallentama data
    if (_titleController.text.trim().isEmpty ||
        priceIsInvalid == true ||
        _selectedDate == null) {
      // Tarkistetaan virheet
      // Näytetään virhe teksti
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content:
              const Text('Please make sure information is entered correctyl!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay...'),
            )
          ],
        ),
      );
      return;
    }

    // Luodaan uusi expense objekti
    final temp = Expense(
        title: _titleController.text,
        amount: enteredPrice!,
        date: _selectedDate!,
        category: _selectedCategory);

    // Lähetetään objekti funktion parametrinä
    widget.onAddExpense(temp);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Osa widgetin elämänkaarta, suoritetaan kun widget poistuu käytöstä
    _titleController.dispose();
    _priceController.dispose(); // Jos ei poisteta voi aiheuttaa memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 0)),
          TextField(
            controller: _titleController, // Linkitetään Textfield ja controller
            maxLength: 50,
            // keyboardType: TextInputType.text, = Oletus
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '€ ',
                    suffixText:
                        ' \$', // Escape syntaksi, koska $ osana dart kieltä
                    label: Text('Price'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Ternary operaatio, yhden rivin if else
                    Text(
                      _selectedDate == null // Vertailu, true tai false
                          ? 'Select Date' // ? tehdään true
                          : formatter.format(_selectedDate!),
                    ), // : tehdään false
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.edit_calendar_outlined),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return; // Lopettaa funktion suorituksen (onchanged)
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
