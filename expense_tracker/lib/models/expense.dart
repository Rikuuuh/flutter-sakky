import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('d/M/y');
const uuid = Uuid();

// Compile time data
enum Category { food, leisure, theater, work }

const categoryIcons = {
  Category.food: Icons.food_bank,
  Category.leisure: Icons.flight_outlined,
  Category.theater: Icons.theaters_outlined,
  Category.work: Icons.work_history_outlined,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  // Suodattaa listan ostoksia ja tallentaa vain oikean kategorian ostokset
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses // Vertailuoperaatio
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  // Ostoksien summa
  double get totalExpenses {
    double sum = 0;

    // Lasketaan summa
    // for (int i = 0; i < expenses.length; i++) {}

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
