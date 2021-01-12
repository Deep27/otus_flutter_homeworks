import 'dart:async';
import 'dart:convert' as convert;

import 'package:cocktaildbhttpusing/src/dto/cocktail_definition_dto.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_definition.dart';
import 'package:cocktaildbhttpusing/src/repository/async_cocktail_repository.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_category_service.dart';
import 'package:http/http.dart' as http;

class CocktailDefinitionService {
  static final CocktailDefinitionService _cocktailService = CocktailDefinitionService._();

  factory CocktailDefinitionService() {
    return _cocktailService;
  }

  CocktailDefinitionService._();

  final _cocktailCategoryService = CocktailCategoryService();
  final _cocktailStreamController =
  StreamController<Iterable<CocktailDefinition>>.broadcast();

  Stream<Iterable<CocktailDefinition>> get onCocktailDefinitionReceiveEvent =>
      _cocktailStreamController.stream;

  void dispose() {
    _cocktailStreamController?.close();
  }

  Future<Iterable<CocktailDefinition>> fetchCocktailDefinitionsByCocktailCategory(
      CocktailCategory category) async {
    _cocktailStreamController.add(null);

    _cocktailCategoryService.tappedCategory.value = category;

    final url =
        '${AsyncCocktailRepository.baseUrl}/filter.php?c=${category.value}';
    var response = await http.get(
      url,
      headers: AsyncCocktailRepository.headers,
    );

    final result = <CocktailDefinition>[];
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      try {
        final drinks = jsonResponse['drinks'] as Iterable<dynamic>;
        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDefinitionDto.fromJson(json));

        for (final dto in dtos) {
          result.add(CocktailDefinition(
            id: dto.idDrink,
            isFavourite: true,
            name: dto.strDrink,
            drinkThumbUrl: dto.strDrinkThumb,
          ));
        }
      } catch (_) {} finally {
        _cocktailStreamController.add(result);
      }
    } else {
      _cocktailStreamController.addError('Status code ${response.statusCode}');
    }

    return result;
  }
}
