import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

// Tästä tiedostosta alkaa widget puu

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // Lista käyttäjän ostoksista
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Jauheliha 200g',
        amount: 2.99,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Theater',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Travel',
        amount: 499.99,
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        title: 'Work',
        amount: 49.99,
        date: DateTime.now(),
        category: Category.work),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Chart Goes Here'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
