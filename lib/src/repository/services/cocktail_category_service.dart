import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';

class CocktailCategoryService {
  static final CocktailCategoryService _cocktailCategoryService =
      CocktailCategoryService._();

  factory CocktailCategoryService() {
    return _cocktailCategoryService;
  }

  CocktailCategoryService._();

  CocktailCategory tappedCategory = CocktailCategory.first;
  List<CocktailCategory> _cocktailCategories = CocktailCategory.values.toList();

  List<CocktailCategory> get cocktailCategories => _cocktailCategories;
}
