import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

// Compile time data
enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icon(Icons.food_bank),
  Category.travel: Icon(Icons.flight_outlined),
  Category.leisure: Icon(Icons.theaters_outlined),
  Category.work: Icon(Icons.work_history_outlined),
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
