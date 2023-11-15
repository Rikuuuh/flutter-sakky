import 'package:pizza/models/ingredient.dart';

const Map<String, List<Ingredient>> categorizedIngredients = {
  'Lihat': [
    Ingredient('beef\'n\'roast-naudanjauheliha', 1.00),
  ],
  'Kasvikset': [
    Ingredient('ananas', 0.50),
  ],
  'Juustot': [
    Ingredient('feta', 1.00),
  ],
  'Kalat': [
    Ingredient('tonnikala', 1.00),
    Ingredient('katkarapu', 2.00),
  ],
};

const fundamentIngredients = [
  FinalIngredient('normaali pizzapohja', 0.00),
  FinalIngredient('gluteeniton pizzapohja', 2.50),
  FinalIngredient('ketopizzapohja', 3.00),
  FinalIngredient('runsaskuituinen pizzapohja', 0.00)
];

const dressingIngredients = [
  FinalIngredient('tomaattikastike', 0.00),
  FinalIngredient('mexicana-kastike', 1.00),
  FinalIngredient('cheddarjuustokastike', 1.00),
  FinalIngredient('kebabkastike', 1.00)
];

const cheeseIngredients = [
  FinalIngredient('Kotipizza-juusto', 0.00),
  FinalIngredient('Ei juustoa, kiitos', 0.00),
  FinalIngredient('puoli juustoa', 0.00)
];
