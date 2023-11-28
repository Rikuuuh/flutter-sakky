import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/favorites_provider.dart';

// k on käytäntö flutterissa const arvoja varten

const kInitialFilters = {
  // Määritellään kaikki false, jotta ei tule null ongelmia
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// Riverpod widgetit, niiden käyttö mahdolistaa ominaisuudet
// (Stateful Widget => ConsumerStatefulWidget)
// (StatelessWidget => ConsumerWidget)
class TabsScreen extends ConsumerStatefulWidget {
  // Riverpod widget
  const TabsScreen({super.key});

  @override
  // State => ConsumerState
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0; // Tämän perusteella näytetään oikea sivu
  // Funktio / Metodi
  // Kaikki metodit ovat funktioita,
  // mutta vain luokan funktiot ovat metodeja

  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // pushReplacement == korvataan nykyinen screen uudella screenillä
      // Yleinen esimerkki on datan haku tietokannasta
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lisätään muuttuja johon tallenetaan suodatettu aterialista
    // Käyttäjän valinnan perusteella
    // Säilytetäänkö ateria vai ei (where logiikka)

    // ref on osana RiverPod pakettia
    // ref.read() <- lukee datan kerran
    // suositellaan watch, se suorittaa build uudestaan jos data muuttuu
    // eli päivittää käyttöliittymään uuden datan
    final meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      // Jos käyttäjä on valinnut gluten free && ateria ei ole gluten free
      if (_selectedFilters[Filter.glutenFree]! && meal.isGlutenFree == false) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! &&
          meal.isLactoseFree == false) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && meal.isVegetarian == false) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && meal.isVegan == false) {
        return false;
      }
      return true;
    }).toList(); // Iterable => List

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    // Jos indeksi onkin 1, eli suosikit
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(meals: favoriteMeals);
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_sharp), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
