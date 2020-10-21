import 'dart:convert' as convert;
import 'dart:io';

import 'package:cocktaildbhttpusing/src/dto/ingredient_dto.dart';
import 'package:cocktaildbhttpusing/src/model/ingredient.dart';
import 'package:cocktaildbhttpusing/src/models.dart';
import 'package:cocktaildbhttpusing/src/dto/cocktail_definition_dto.dart';
import 'package:cocktaildbhttpusing/src/dto/cocktail_dto.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_definition.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_type.dart';
import 'package:http/http.dart' as http;

class AsyncCocktailRepository {
  static const Map<String, String> _headers = const {
    'x-rapidapi-key': 'e5b7f97a78msh3b1ba27c40d8ccdp105034jsn34e2da32d50b',
    'x-rapidapi-host': 'the-cocktail-db.p.rapidapi.com',
  };

  Future<Cocktail> fetchCocktailDetails(String id) async {
    Cocktail result;

    var client = http.Client();
    try {
      final url = 'https://the-cocktail-db.p.rapidapi.com/lookup.php?i=$id';
      var response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDto.fromJson(json));
        if (dtos.length > 0) {
          result = Cocktail.fromDto(dtos.first);
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result;
  }

  Future<Iterable<CocktailDefinition>> fetchCocktailsByCocktailType(
      CocktailType cocktailType) async {
    var result = <CocktailDefinition>[];

    var client = http.Client();
    try {
      final url =
          'https://the-cocktail-db.p.rapidapi.com/filter.php?a=${cocktailType.value}';
      var response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

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
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result;
  }

  Future<Iterable<Cocktail>> fetchPopularCocktails() async {
    var result = <Cocktail>[];

    var client = http.Client();
    try {
      const url = 'https://the-cocktail-db.p.rapidapi.com/popular.php';
      var response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDto.fromJson(json));

        for (final dto in dtos) {
          final cocktail = Cocktail.fromDto(dto);
          result.add(cocktail);
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result;
  }

  Future<Cocktail> getRandomCocktail() async {
    Cocktail result;

    var client = http.Client();
    try {
      const url = 'https://the-cocktail-db.p.rapidapi.com/random.php';
      var response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDto.fromJson(json));
        if (dtos.length > 0) {
          result = Cocktail.fromDto(dtos.first);
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result;
  }

  Future<Ingredient> lookupIngredientById(int id) async {
    Ingredient result;

    var client = http.Client();
    try {
      final url = 'https://rapidapi.p.rapidapi.com/lookup.php?iid=$id';
      var response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var ingredients = jsonResponse['ingredients'] as Iterable<dynamic>;

        final dtos = ingredients
            .cast<Map<String, dynamic>>()
            .map((json) => IngredientDto.fromJson(json));
        if (dtos.length > 0) {
          result = Ingredient.fromDto(dtos.first);
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result;
  }
}
