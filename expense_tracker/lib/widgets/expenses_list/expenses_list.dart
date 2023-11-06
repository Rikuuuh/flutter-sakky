import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

// Tämä widget ottaa listan vastaan ja generoi listan sen sisällöstä

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Näyttää listan kaikista ostoksista mitkä käyttäjä on tallentanut
      // Expense trackeriin
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        // Tekee widgetin jonka käyttäjä voi "poistaa", eli tässä tapauksessa
        // Ostoksen expense trackerista
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.5),
          margin: EdgeInsets.symmetric(
              // Yksittäinen tyylittely vaikka on Theme käytössä
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
