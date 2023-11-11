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
  FundamentIngredients('normaali pizzapohja', 0.00),
  FundamentIngredients('gluteeniton pizzapohja', 2.50),
  FundamentIngredients('ketopizzapohja', 3.00),
  FundamentIngredients('runsaskuituinen pizzapohja', 0.00)
];

const dressingIngredients = [
  DressingIngredients('tomaattikastike', 0.00),
  DressingIngredients('mexicana-kastike', 1.00),
  DressingIngredients('cheddarjuustokastike', 1.00),
  DressingIngredients('kebabkastike', 1.00)
];
