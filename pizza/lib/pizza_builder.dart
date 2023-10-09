import 'package:flutter/material.dart';
import 'package:pizza/models/ingredient.dart';
import 'package:pizza/select_ingredients.dart';

class PizzaBuilder extends StatefulWidget {
  const PizzaBuilder({super.key});

  @override
  State<PizzaBuilder> createState() => _PizzaBuilderState();
}

class _PizzaBuilderState extends State<PizzaBuilder> {
  final List<Map<Ingredient, int>> selectedIngredients = [];

  void incrementIngredient(Ingredient ingredient) {
    setState(() {
      final Map<Ingredient, int> ingredientMap = selectedIngredients
          .firstWhere((element) => element.containsKey(ingredient), orElse: () {
        final newMap = {ingredient: 1};
        selectedIngredients.add(newMap);
        return newMap;
      });
      ingredientMap[ingredient] = (ingredientMap[ingredient] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(76, 137, 255, 3),
              Color.fromARGB(255, 0, 0, 0),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
          child: SelectIngredients(selectedIngredients,
              onAddIngredient: incrementIngredient),
        ),
      ),
    );
  }
}
