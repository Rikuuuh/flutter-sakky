class Ingredient {
  const Ingredient(this.name, this.price);

  final String name;
  final double price;
}

class FinalIngredient {
  const FinalIngredient(this.name, this.price);

  final String name;
  final double price;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FinalIngredient &&
        other.name == name &&
        other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode;
}
