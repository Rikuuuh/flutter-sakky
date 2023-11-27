import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

// k on käytäntö flutterissa const arvoja varten

const kInitialFilters = {
  // Määritellään kaikki false, jotta ei tule null ongelmia
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0; // Tämän perusteella näytetään oikea sivu
  // Funktio / Metodi
  // Kaikki metodit ovat funktioita,
  // mutta vain luokan funktiot ovat metodeja
  // Jos ateria ei ole suosikeissa, lisätään se sinne
  // Jos ateria on jo suosikeissa, otetaan se pois
  final List<Meal> _favoriteMeals = [];
  // ignore: unused_field
  Map<Filter, bool> _selectedFilters = kInitialFilters;
  void _toggleMealFavoriteStatus(Meal meal) {
    // Tutkitaan onko ateria jo listassa

    final isExisting = _favoriteMeals.contains(meal);

    // Suoritetaan poisto ja lisäys
    // if(_favoriteMeals.contains(meal)){}
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage("${meal.title} removed from favorites!");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("${meal.title} added to favorites!");
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars(); // Poistetaan vanha viesti
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }

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
          builder: (context) => const FiltersScreen(),
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
    final availableMeals = dummyMeals.where((meal) {
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

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    // Jos indeksi onkin 1, eli suosikit
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
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
