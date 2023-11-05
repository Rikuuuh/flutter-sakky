import 'package:flutter/material.dart';
import 'package:pizza/models/ingredient.dart';
import 'package:pizza/data/ingredients.dart';
import 'package:pizza/pizza_button.dart';
import 'package:pizza/view_screen.dart';

class SelectIngredients extends StatelessWidget {
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
  final List<Map<Ingredient, int>> selectedIngredients;
  final bool isMediumSelected;
  final int totalPrice;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ViewScreen(
            isMediumSelected: isMediumSelected,
            totalPrice: totalPrice,
          ),
          PizzaButton(
            isMediumSelected: isMediumSelected,
            totalPrice: totalPrice,
            onSizeToggle: onSizeToggle,
          ),
          // ... = SPREAD OPERAATIO; purkaa datarakenteen listasta
          // yksittäisiksi widgeteiksi
          ...ingredients.map((item) {
            // Haetaan käytävän Ingredient objektin (item) map<Ingredient, int>
            // !<key, value>! Ja siitä objektista saadaan lukumäärä, montako
            // kertaa se on valittu.
            // map löytyy selectedIngredients listasta.
            final mapOfOneSelectedIngredient = selectedIngredients.firstWhere(
              (oneMap) => oneMap.containsKey(item),
              orElse: () => {},
            );

            // Otetaan avain-arvo parista arvo talteen <int>!
            final numberOfPortions = mapOfOneSelectedIngredient[item];

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    onAddIngredient(item);
                  },
                  child: Text(
                    '${item.name} = $numberOfPortions',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    onRemoveIngredient(item);
                  },
                  icon: const Icon(
                    Icons.remove_circle_outlined,
                    color: Color.fromARGB(255, 255, 10, 0),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    onAddIngredient(item);
                  },
                  icon: const Icon(
                    Icons.add_circle_outlined,
                    color: Color.fromARGB(255, 47, 185, 47),
                  ),
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}
