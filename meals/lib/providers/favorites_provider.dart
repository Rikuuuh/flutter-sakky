import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

// Geneerinen, voi sisältää mitä tahansa dataa
// List<jotakinDataa>
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // 1. data
  FavoriteMealsNotifier()
      : super([
          // == state alempana
        ]); // Oletuksena tyhjä lista

  // 2. metodit, jotka muokkaa dataa
  // Riverpod, data täytyy muokata immutable tavalla
  // mutable: muokataan objektin dataa heap:ssa
  // immutable: luodaan kokonaan uusi objekti heap:iin ja korvataan vanha objekti
  // eli korvataan vanhan objektin viittaus uudella objektilla
  bool toggleMealFavoritesStatus(Meal meal) {
    // contains metodi ei muokkaa listaa
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite == true) {
      // where on immutable, eli se tekee uuden kopion
      // kopioidaan kaikki ateriat, joiden id ei ole se id, joka halutaan poistaa
      state = state.where((m) => m.id != meal.id).toList();
      return false; // poistettu
    } else {
      // spread ... operaatio luo kopion elementeistä ja laitetaan ne
      // uuden listan [] sisälle
      state = [...state, meal]; // lopksi uusi elementti pilkun jälkeen
      return true; // lisätty
    }

    // Tässä on immutable datan muokkaus, [] luo uuden listan
    // ja laitetaan kokonaan usi lista objekti vanhan tilalle
    // state = [];

    // Tämä on mutable keino, eli muokataan olemassa olevaa objektia/dataa
    // state.add(meal);
  }
}

// Dynaaminen data, StateNotifierProvider
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
