import 'package:flutter/material.dart';
import 'package:cocktaildbhttpusing/src/repository/async_cocktail_repository.dart';

class ImageHeader extends StatelessWidget {
  const ImageHeader(this.imageUrl);

  final String imageUrl;

  final AsyncCocktailRepository cocktailApi = const AsyncCocktailRepository();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(imageUrl),
        const Positioned(
          child: const Padding(
            padding: const EdgeInsets.all(24.0),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: () {
              cocktailApi.lookupIngredientById(552);
            },
            child: const Padding(
              padding: const EdgeInsets.all(24.0),
              child: const Icon(
                Icons.open_in_new,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
