import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

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

  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year, now.month + 1, now.day);
    showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
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
                    const Text('Selected Date'),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month_rounded),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_priceController.text);
                },
                child: const Text('Save Expense'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
