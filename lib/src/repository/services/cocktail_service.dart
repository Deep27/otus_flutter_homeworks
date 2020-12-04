import 'dart:async';
import 'dart:convert' as convert;

import 'package:cocktaildbhttpusing/src/dto/cocktail_definition_dto.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_definition.dart';
import 'package:cocktaildbhttpusing/src/repository/async_cocktail_repository.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_category_service.dart';
import 'package:http/http.dart' as http;

class CocktailService {
  static final CocktailService _cocktailService = CocktailService._();

  factory CocktailService() {
    return _cocktailService;
  }

  CocktailService._();

  final _cocktailCategoryService = CocktailCategoryService();
  final _cocktailStreamController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get onCocktailReceiveEvent =>
      _cocktailStreamController.stream;

  void dispose() {
    _cocktailStreamController?.close();
  }

  Future<void> fetchCocktailsByCocktailCategory(
      CocktailCategory category) async {
    _cocktailStreamController.add(null);

    _cocktailCategoryService.tappedCategory = category;

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
        _cocktailStreamController.add(result.toList());
      } catch (_) {
        _cocktailStreamController.add(jsonResponse['drinks']);
      }
    } else {
      _cocktailStreamController.addError('Status code ${response.statusCode}');
    }
  }
}
