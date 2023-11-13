import 'package:flutter/material.dart';
import 'package:pizza/models/ingredient.dart';
import 'package:pizza/select_ingredients.dart';

class PizzaBuilder extends StatefulWidget {
  const PizzaBuilder({super.key});

  @override
  State<PizzaBuilder> createState() => _PizzaBuilderState();
}

class _PizzaBuilderState extends State<PizzaBuilder> {
  bool isMediumSelected = true;
  int totalPrice = 1090;

  Map<Ingredient, int> selectedIngredients = {};
  // Funktio joka lisää ingredientin ja päivittää TotalPricen
  void incrementIngredient(Ingredient ingredient) {
    setState(() {
      selectedIngredients.update(
        ingredient,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );

      calculateTotalPrice();
    });
  }

  // Poistaa ingredientin ja päivittää TotalPricen
  void removeIngredient(Ingredient ingredient) {
    setState(() {
      final currentQuantity = selectedIngredients[ingredient];
      if (currentQuantity != null && currentQuantity > 1) {
        selectedIngredients[ingredient] = currentQuantity - 1;
      } else {
        selectedIngredients.remove(ingredient);
      }

      calculateTotalPrice();
    });
  }

  // BasePrice on medium pizza; jokaisen ingredientin lisäyksen jälkeen setstaten sisällä uus TotalPrice
  void calculateTotalPrice() {
    int basePrice = isMediumSelected ? 1090 : 2090;
    double ingredientsPrice = 0;

    selectedIngredients.forEach((ingredient, quantity) {
      ingredientsPrice += ingredient.price * quantity;
    });

    int calculatedTotalPrice = basePrice + (ingredientsPrice * 100).toInt();

    setState(() {
      totalPrice = calculatedTotalPrice;
    });
  }

  // Funktio jolla vaihdetaan medium / large pizzan välillä
  void toggleSize(bool isMedium) {
    setState(() {
      isMediumSelected = isMedium;
      calculateTotalPrice();
    });
  }

  void toggleNewPizza() {
    setState(() {
      // todo
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
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  // Buttonit tulevat valituiksi jos on valittuna raaka-aineita
                  onPressed: selectedIngredients.isNotEmpty
                      ? () {
                          // TO DO
                        }
                      : null,
                ),
                const Text('1'),
                IconButton(
                  icon: const Icon(Icons.add),
                  // Buttonit tulevat valituiksi jos on valittuna raaka-aineita
                  onPressed: selectedIngredients.isNotEmpty
                      ? () {
                          // TO DO
                        }
                      : null,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      // Jos on tyhjä "Kori" niin näyttää eri tekstin
                      selectedIngredients.isEmpty
                          ? 'Lisää ainakin yksi täyte'
                          : 'Lisää tilaukseen €${(totalPrice / 100).toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
