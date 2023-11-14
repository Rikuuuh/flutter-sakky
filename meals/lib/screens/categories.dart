import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  // Tällä siirrytään Meals näkymään
  void _selectCategory(BuildContext context, Category selectedCategory) {
    // Haetaan kaikki valitun kategorian ateriat
    // where metodin avulla voidaan suodattaa vain ne asiat, jotka halutaan
    // where tutkii listan elementti kerrallaan
    // ja annetaan logiikka, jonka perusteella elementti valitaan tai hylätään
    // => oikealla puolella pitää saada operaatio joka palauttaa true tai false
    // contains tutkii listan sisällön ja palauttaa true tai false, löytyykö sen parametri
    //      listasta vai ei
    // Otetaan lopuksi talteen muuttujaan
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(selectedCategory.id))
        .toList();

    // Navigator.push(context, route);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MealsScreen(title: selectedCategory.title, meals: filteredMeals),
      ),
    );
  }

  // Flutterissa näkymät (screens) hallitaan stack:issa,
  // joka on pino näkymä objekteja (widgettejä)
  // pinon (stack) korkein objekti näytetään käyttäjälle
  // Operaatiot ovat push (lisäys) ja pop (poisto)
  // Aina lisätään päälle ja poistetaan päältä
  // LIFO  <-  stack idea (FIFO <- queue(jono) idea)
  // Esim:
  //        product-page <- aktiivinen näkymä
  //        products-page
  //        front-page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                })
        ],
      ),
    );
  }
}
