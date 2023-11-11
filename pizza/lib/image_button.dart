import 'package:flutter/material.dart';
import 'package:pizza/models/ingredient.dart';

class ImageButton extends StatefulWidget {
  final void Function(Ingredient) onIngredientSelected;

  const ImageButton({
    Key? key,
    required this.onIngredientSelected,
    required this.selectedIngredients,
    required this.onAddIngredient,
    required this.onRemoveIngredient,
  }) : super(key: key);

  final void Function(Ingredient) onAddIngredient;
  final void Function(Ingredient) onRemoveIngredient;
  final Map<Ingredient, int> selectedIngredients;
  @override
  ImageButtonState createState() => ImageButtonState();
}

class ImageButtonState extends State<ImageButton> {
  final List<Map<String, dynamic>> ingredientData = [
    {
      'name': 'valkosipuli',
      'image': 'assets/images/valkosipuli.png',
      'price': 0.30,
      'ingredient': const Ingredient('valkosipuli', 0.30),
    },
    {
      'name': 'kirsikkatomaatti',
      'image': 'assets/images/tomaatti.png',
      'price': 0.50,
      'ingredient': const Ingredient('kirsikkatomaatti', 0.50),
    },
    {
      'name': 'aura@-juusto',
      'image': 'assets/images/juusto.png',
      'price': 0.70,
      'ingredient': const Ingredient('aura@-juusto', 0.70),
    },
  ];

  List<bool> isSelected = [false, false, false];
  @override
  void initState() {
    super.initState();

    isSelected = ingredientData.map((data) {
      final ingredient = data['ingredient'] as Ingredient;

      return widget.selectedIngredients[ingredient] != null &&
          widget.selectedIngredients[ingredient]! > 0;
    }).toList();
  }

  void handleIngredientSelected(Ingredient ingredient, int index) {
    setState(() {
      isSelected[index] = !isSelected[index];

      if (isSelected[index]) {
        widget.onAddIngredient(ingredient);
      } else {
        widget.onRemoveIngredient(ingredient);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ingredientData.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> data = entry.value;
        Ingredient ingredient = data['ingredient'] as Ingredient;

        bool isCurrentlySelected =
            widget.selectedIngredients.containsKey(ingredient) &&
                widget.selectedIngredients[ingredient]! > 0;

        return Expanded(
          child: InkWell(
            onTap: () {
              handleIngredientSelected(ingredient, index);
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(2, 1, 3, 1),
                  width: 90,
                  height: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(data['image']),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Text(
                    data['name'],
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -3,
                  child: Text(
                    '${data['price'].toStringAsFixed(2)} €',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isCurrentlySelected)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
