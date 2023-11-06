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
  bool isMediumSelected = true;
  int totalPrice = 1090;

  void incrementIngredient(Ingredient ingredient) {
    setState(() {
      final Map<Ingredient, int> ingredientMap = selectedIngredients
          .firstWhere((element) => element.containsKey(ingredient), orElse: () {
        final newMap = {ingredient: 0};
        selectedIngredients.add(newMap);
        return newMap;
      });
      ingredientMap[ingredient] = (ingredientMap[ingredient] ?? 0) + 1;
    });
  }

  void removeIngredient(Ingredient ingredient) {
    setState(() {
      final Map<Ingredient, int> ingredientMap = selectedIngredients
          .firstWhere((element) => element.containsKey(ingredient), orElse: () {
        final newMap = {ingredient: 1};
        selectedIngredients.remove(newMap);
        return newMap;
      });
      ingredientMap[ingredient] = (ingredientMap[ingredient] ?? 0) - 1;
    });
  }

  void calculateTotalPrice() {
    int basePrice = isMediumSelected ? 1090 : 2090;
    int ingredientsPriceSmall = 0;
    int calculatedTotalPrice = basePrice + ingredientsPriceSmall;

    setState(() {
      totalPrice = calculatedTotalPrice;
    });
  }

  void toggleSize(bool isMedium) {
    setState(() {
      isMediumSelected = isMedium;
      calculateTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: SelectIngredients(
              onSizeToggle: toggleSize,
              selectedIngredients: selectedIngredients,
              onAddIngredient: incrementIngredient,
              onRemoveIngredient: removeIngredient,
              isMediumSelected: isMediumSelected,
              totalPrice: totalPrice,
              onCalculateTotalPrice: calculateTotalPrice),
        ),
      ),
    );
  }
}
