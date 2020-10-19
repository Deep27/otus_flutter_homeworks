import 'package:flutter/material.dart';
import 'package:homework/models/models.dart';
import 'package:homework/pages/cocktail_detail/widgets/cocktail_info.dart';
import 'package:homework/pages/cocktail_detail/widgets/cocktail_ingredients.dart';
import 'package:homework/pages/cocktail_detail/widgets/cocktail_rating.dart';
import 'package:homework/pages/cocktail_detail/widgets/image_header.dart';
import 'package:homework/pages/cocktail_detail/widgets/instructions.dart';

class CocktailDetailPage extends StatelessWidget {
  const CocktailDetailPage(
    this.cocktail, {
    Key key,
  }) : super(key: key);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageHeader('assets/images/mohito.jpg'),
              CocktailInfo(cocktail),
              CocktailIngredients(cocktail),
              Instructions(cocktail),
              CocktailRating(cocktail),
            ],
          ),
        ),
      ),
    );
  }
}
