import 'dart:async';
import 'dart:convert' as convert;

import 'package:cocktaildbhttpusing/src/dto/cocktail_definition_dto.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_definition.dart';
import 'package:cocktaildbhttpusing/src/repository/async_cocktail_repository.dart';
import 'package:cocktaildbhttpusing/src/repository/query_status.dart';
import 'package:cocktaildbhttpusing/src/repository/response.dart';
import 'package:http/http.dart' as http;

class CocktailCategoryService {
  final _cocktailCategoryStreamController =
      StreamController<Response<List<CocktailDefinition>>>.broadcast();

  Stream<Response<List<CocktailDefinition>>> get onCocktailReceiveEvent =>
      _cocktailCategoryStreamController.stream;

  void dispose() {
    _cocktailCategoryStreamController?.close();
  }

  Future<Iterable<CocktailDefinition>> fetchCocktailsByCocktailCategory(
      CocktailCategory category) async {
    _cocktailCategoryStreamController
        .add(Response(status: QueryStatus.waiting));

    var result = <CocktailDefinition>[];

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

        for (final dto in dtos) {
          result.add(CocktailDefinition(
            id: dto.idDrink,
            isFavourite: true,
            name: dto.strDrink,
            drinkThumbUrl: dto.strDrinkThumb,
          ));
        }
        _cocktailCategoryStreamController.add(
            Response<List<CocktailDefinition>>(
                status: QueryStatus.success, response: result.toList()));
      } catch (e) {
        if (jsonResponse['drinks'] == 'None Found') {
          _cocktailCategoryStreamController
              .add(Response<List<CocktailDefinition>>(
            status: QueryStatus.success,
            response: [], // @TODO return 'none found' response
          ));
        } else {
          _cocktailCategoryStreamController.addError('Unknown error');
        }
      }
    } else {
      _cocktailCategoryStreamController
          .addError('Status code ${response.statusCode}');
    }

    return result;
  }
}
