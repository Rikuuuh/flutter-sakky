import 'package:flutter/material.dart';
import 'package:pizza/models/ingredient.dart';
import 'package:pizza/data/ingredients.dart';

class SelectIngredients extends StatelessWidget {
  const SelectIngredients(
    this.selectedIngredients, {
    super.key,
    required this.onAddIngredient,
  });

  final void Function(Ingredient) onAddIngredient;
  final List<Map<Ingredient, int>> selectedIngredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/pizza.jpg',
        ),
        //const Text('text here'),
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
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
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
                  color: Color.fromARGB(255, 50, 255, 0),
                ),
              )
            ],
          );
        }),
      ],
    );
  }
}
