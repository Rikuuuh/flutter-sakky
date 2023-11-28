import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

// Staattinen data
final mealsProvider = Provider(
  // riverpod paketista
  (ref) {
    return dummyMeals;
  },
);
