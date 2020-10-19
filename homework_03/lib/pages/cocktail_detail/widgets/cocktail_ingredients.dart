import 'package:flutter/material.dart';
import 'package:homework/models/models.dart';

class CocktailIngredients extends StatelessWidget {
  CocktailIngredients(this.cocktail);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Column(
        children: <Widget>[
          Text(
            'Ингредиенты:',
            style: Theme.of(context).textTheme.headline3,
          ),
          ...cocktail.ingredients
              .map((i) => _Ingredient(i.ingredientName, i.measure)),
        ],
      ),
    );
  }
}

class _Ingredient extends StatelessWidget {
  _Ingredient(this.name, this.measure);

  final String name;
  final String measure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          Text(measure),
        ],
      ),
    );
  }
}
