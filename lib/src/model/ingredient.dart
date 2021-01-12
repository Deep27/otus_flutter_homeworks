import 'package:cocktaildbhttpusing/src/dto/ingredient_dto.dart';

class Ingredient {
  final int id;
  final String name;
  final String description;
  final String type;
  final String alcohol;
  final String abv;
  final bool isAlcoholic;

  Ingredient({
    this.id,
    this.name,
    this.description,
    this.type,
    this.alcohol,
    this.abv,
    this.isAlcoholic,
  });

  factory Ingredient.fromDto(IngredientDto ingredientDto) => Ingredient(
      id: int.parse(ingredientDto.idIngredient),
      name: ingredientDto.strIngredient,
      description: ingredientDto.strDescription,
      type: ingredientDto.strType,
      alcohol: ingredientDto.strAlcohol,
      abv: ingredientDto.strABV,
      isAlcoholic: ingredientDto.strAlcohol == 'yes');
}
