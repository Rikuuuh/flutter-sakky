import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/data/ingredients.dart';
import 'package:pizza/image_button.dart';
import 'package:pizza/models/ingredient.dart';

class PizzaButton extends StatefulWidget {
  const PizzaButton({
    super.key,
    required this.isMediumSelected,
    required this.totalPrice,
    required this.onSizeToggle,
    required this.selectedIngredients,
    required this.onAddIngredient,
    required this.onRemoveIngredient,
    required this.onCalculateTotalPrice,
    required this.onSelectCheese,
    required this.onSelectDressing,
    required this.onSelectFundament,
    required this.selectedCheese,
    required this.selectedDressing,
    required this.selectedFundament,
  });
  final bool isMediumSelected;
  final int totalPrice;
  final void Function(bool) onSizeToggle;
  final void Function(Ingredient) onAddIngredient;
  final void Function(Ingredient) onRemoveIngredient;
  final void Function() onCalculateTotalPrice;
  final Map<Ingredient, int> selectedIngredients;
  final FinalIngredient selectedFundament;
  final FinalIngredient selectedDressing;
  final FinalIngredient selectedCheese;
  final Function(FinalIngredient) onSelectFundament;
  final Function(FinalIngredient) onSelectDressing;
  final Function(FinalIngredient) onSelectCheese;

  @override
  State<PizzaButton> createState() => _PizzaButtonState();
}

class _PizzaButtonState extends State<PizzaButton> {
  @override
  Widget build(BuildContext context) {
    Color activeColor = const Color.fromARGB(255, 34, 139, 34);
    Color defaultColor = Colors.white;

    return Container(
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Perfetta',
            style: GoogleFonts.lato(
                color: Colors.black, fontSize: 33, fontWeight: FontWeight.bold),
          ),
          Text(
            'Pizza kuin suoraan päiväunistasi, sillä sen täytteet päätät sinä. Kokeile, miksaa, hulluttele ja löydä se maistuvin makumaailma juuri sinulle',
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 11),
          Text(
            'KOKO',
            style: GoogleFonts.lato(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.onSizeToggle(true);
                    });
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(color: activeColor, width: 1.5),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        widget.isMediumSelected ? activeColor : defaultColor),
                  ),
                  child: Text(
                    'Medium',
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.isMediumSelected
                            ? defaultColor
                            : activeColor),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.onSizeToggle(false);
                    });
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(color: activeColor, width: 1.5),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        !widget.isMediumSelected ? activeColor : defaultColor),
                  ),
                  child: Text('Large',
                      style: TextStyle(
                          fontSize: 20,
                          color: !widget.isMediumSelected
                              ? defaultColor
                              : activeColor)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            'VIIMEISTELE',
            style: GoogleFonts.lato(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Stack(
            children: <Widget>[
              ImageButton(
                selectedIngredients: widget.selectedIngredients,
                onAddIngredient: widget.onAddIngredient,
                onRemoveIngredient: widget.onRemoveIngredient,
                onIngredientSelected: (Ingredient ingredient) {
                  if (widget.selectedIngredients.containsKey(ingredient) &&
                      widget.selectedIngredients[ingredient]! > 0) {
                    widget.onRemoveIngredient(ingredient);
                  } else {
                    widget.onAddIngredient(ingredient);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            'POHJA',
            style: GoogleFonts.lato(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 13),
          DropdownButton<FinalIngredient>(
            value: widget.selectedFundament,
            isExpanded: true,
            items: fundamentIngredients.map((FinalIngredient ingredient) {
              return DropdownMenuItem<FinalIngredient>(
                value: ingredient,
                child: Text(
                  '${ingredient.name} (+${ingredient.price.toStringAsFixed(2)}€)',
                  style: GoogleFonts.lato(fontSize: 15),
                ),
              );
            }).toList(),
            onChanged: (FinalIngredient? newValue) {
              if (newValue != null) {
                widget.onSelectFundament(newValue);
              }
            },
          ),
          DropdownButton<FinalIngredient>(
            value: widget.selectedDressing,
            isExpanded: true,
            items: dressingIngredients.map((FinalIngredient ingredient) {
              return DropdownMenuItem<FinalIngredient>(
                value: ingredient,
                child: Text(
                    '${ingredient.name} (+${ingredient.price.toStringAsFixed(2)}€)',
                    style: GoogleFonts.lato(fontSize: 15)),
              );
            }).toList(),
            onChanged: (FinalIngredient? newValue) {
              if (newValue != null) {
                widget.onSelectDressing(newValue);
              }
            },
          ),
          DropdownButton<FinalIngredient>(
            value: widget.selectedCheese,
            isExpanded: true,
            items: cheeseIngredients.map((FinalIngredient ingredient) {
              return DropdownMenuItem<FinalIngredient>(
                value: ingredient,
                child: Text(ingredient.name,
                    style: GoogleFonts.lato(fontSize: 15)),
              );
            }).toList(),
            onChanged: (FinalIngredient? newValue) {
              if (newValue != null) {
                widget.onSelectCheese(newValue);
              }
            },
          ),
          Text(
            'LISÄÄ TÄYTTEITÄ',
            style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 0, 100, 3),
                fontSize: 21,
                letterSpacing: -1),
          ),
        ],
      ),
    );
  }
}
