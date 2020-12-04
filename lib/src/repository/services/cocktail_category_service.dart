import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:flutter/cupertino.dart';

class CocktailCategoryService {
  static final CocktailCategoryService _cocktailCategoryService =
      CocktailCategoryService._();

  factory CocktailCategoryService() {
    return _cocktailCategoryService;
  }

  CocktailCategoryService._();

  ValueNotifier<CocktailCategory> tappedCategory =
      ValueNotifier(CocktailCategory.first);
  List<CocktailCategory> _cocktailCategories = CocktailCategory.values.toList();

  List<CocktailCategory> get cocktailCategories => _cocktailCategories;
}
