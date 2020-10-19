import 'package:flutter/material.dart';
import 'package:homework/models/models.dart';

const Color ratingBgColor = Color(0xff1a1926);
const Color ratingStarBgColor = Color(0xff2a2939);

class CocktailRating extends StatelessWidget {
  CocktailRating(this.cocktail);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      color: ratingBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (int i = 0; i < 5; i++) _Star(i < int.parse(cocktail.id) % 5),
        ],
      ),
    );
  }
}

class _Star extends StatelessWidget {
  _Star(this.active);

  final bool active;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        width: 48.0,
        height: 48.0,
        color: ratingStarBgColor,
        child: Icon(
          Icons.star,
          size: 32.0,
          color: active ? Theme.of(context).iconTheme.color : ratingBgColor,
        ),
      ),
    );
  }
}
