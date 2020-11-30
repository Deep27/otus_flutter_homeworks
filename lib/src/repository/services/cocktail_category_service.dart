import 'dart:async';
import 'dart:convert' as convert;

import 'package:cocktaildbhttpusing/src/dto/cocktail_definition_dto.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_definition.dart';
import 'package:cocktaildbhttpusing/src/repository/async_cocktail_repository.dart';
import 'package:http/http.dart' as http;

class CocktailCategoryService {
  static final CocktailCategoryService _singleton =
      CocktailCategoryService._internal();

  factory CocktailCategoryService() {
    return _singleton;
  }

  CocktailCategoryService._internal();

  final _cocktailCategoryStreamController =
      StreamController<dynamic>.broadcast();

  Stream<dynamic> get onCocktailReceiveEvent =>
      _cocktailCategoryStreamController.stream;

  CocktailCategory _tappedCategory = CocktailCategory.first;

  CocktailCategory get tappedCategory => _tappedCategory;

  void dispose() {
    _cocktailCategoryStreamController?.close();
  }

  Future<void> fetchCocktailsByCocktailCategory(
      CocktailCategory category) async {
    _cocktailCategoryStreamController.add(null);

    _tappedCategory = category;

    final url =
        '${AsyncCocktailRepository.baseUrl}/filter.php?c=${category.value}';
    var response = await http.get(
      url,
      headers: AsyncCocktailRepository.headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      try {
        final drinks = jsonResponse['drinks'] as Iterable<dynamic>;
        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDefinitionDto.fromJson(json));

        final result = <CocktailDefinition>[];
        for (final dto in dtos) {
          result.add(CocktailDefinition(
            id: dto.idDrink,
            isFavourite: true,
            name: dto.strDrink,
            drinkThumbUrl: dto.strDrinkThumb,
          ));
        }
        _cocktailCategoryStreamController.add(result.toList());
      } catch (_) {
        _cocktailCategoryStreamController.add(jsonResponse['drinks']);
      }
    } else {
      _cocktailCategoryStreamController
          .addError('Status code ${response.statusCode}');
    }
  }
}
