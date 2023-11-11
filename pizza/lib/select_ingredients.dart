import 'package:flutter/material.dart';
import 'package:pizza/models/ingredient.dart';
import 'package:pizza/data/ingredients.dart';
import 'package:pizza/pizza_button.dart';
import 'package:pizza/view_screen.dart';

class SelectIngredients extends StatefulWidget {
  const SelectIngredients({
    super.key,
    required this.selectedIngredients,
    required this.isMediumSelected,
    required this.totalPrice,
    required this.onAddIngredient,
    required this.onRemoveIngredient,
    required this.onCalculateTotalPrice,
    required this.onSizeToggle,
  });

  final void Function(Ingredient) onAddIngredient;
  final void Function(Ingredient) onRemoveIngredient;
  final void Function() onCalculateTotalPrice;
  final void Function(bool) onSizeToggle;
  final Map<Ingredient, int> selectedIngredients;
  final bool isMediumSelected;
  final int totalPrice;

  @override
  State<SelectIngredients> createState() => _SelectIngredientsState();
}

class _SelectIngredientsState extends State<SelectIngredients> {
  Map<String, bool> selectedIngredients = {};
  Map<Ingredient, int> ingredientQuantities = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ViewScreen(
            isMediumSelected: widget.isMediumSelected,
            totalPrice: widget.totalPrice,
          ),
          PizzaButton(
            isMediumSelected: widget.isMediumSelected,
            totalPrice: widget.totalPrice,
            onSizeToggle: widget.onSizeToggle,
            onAddIngredient: widget.onAddIngredient,
            onRemoveIngredient: widget.onRemoveIngredient,
            selectedIngredients: widget.selectedIngredients,
          ),
          ...categorizedIngredients.keys.map((String category) {
            return ExpansionTile(
              title: Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 34, 139, 34),
                ),
              ),
              collapsedBackgroundColor: const Color.fromARGB(38, 34, 139, 34),
              backgroundColor: const Color.fromARGB(38, 34, 139, 34),
              children: categorizedIngredients[category]!
                  .map((Ingredient ingredient) {
                int currentQuantity = ingredientQuantities[ingredient] ?? 0;
                bool isSelected = currentQuantity > 0;
                return ListTile(
                  title: Text(ingredient.name),
                  subtitle: Text('+${ingredient.price.toStringAsFixed(2)} €'),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Keeps the Row width to a minimum
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.red),
                        onPressed: currentQuantity > 0
                            ? () {
                                setState(() {
                                  ingredientQuantities[ingredient] =
                                      currentQuantity - 1;
                                  widget.onRemoveIngredient(ingredient);
                                  widget.onCalculateTotalPrice();
                                });
                              }
                            : null,
                      ),
                      Text(currentQuantity
                          .toString()), // Shows the current quantity
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          setState(() {
                            ingredientQuantities[ingredient] =
                                currentQuantity + 1;
                            widget.onAddIngredient(ingredient);
                            widget.onCalculateTotalPrice();
                          });
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        ingredientQuantities[ingredient] = 0;
                        widget.onRemoveIngredient(ingredient);
                      } else {
                        ingredientQuantities[ingredient] = 1;
                        widget.onAddIngredient(ingredient);
                      }
                      widget.onCalculateTotalPrice();
                    });
                  },
                );
              }).toList(),
            );
          }).toList(),
        ],
      ),
    );
  }
}
