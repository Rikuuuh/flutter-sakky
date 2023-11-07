class Ingredient {
  const Ingredient(
      this.name, this.gramsPerPortion, this.caloriesPer100g, this.price);

  final String name;
  final double gramsPerPortion;
  final double caloriesPer100g;
  final double price;
}

class FinalIngredients {
  const FinalIngredients(this.name, this.price);

  final String name;
  final double price;
}
