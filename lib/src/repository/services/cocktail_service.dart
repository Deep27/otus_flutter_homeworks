import 'dart:async';
import 'dart:convert' as convert;

import 'package:cocktaildbhttpusing/src/dto/cocktail_dto.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail.dart';
import 'package:cocktaildbhttpusing/src/repository/async_cocktail_repository.dart';
import 'package:http/http.dart' as http;

class CocktailService {
  static final CocktailService _cocktailService = CocktailService._();

  factory CocktailService() {
    return _cocktailService;
  }

  CocktailService._();

  final _cocktailStreamController =
      StreamController<Cocktail>.broadcast();

  Stream<Cocktail> get onCocktailReceiveEvent =>
      _cocktailStreamController.stream;

  void dispose() {
    _cocktailStreamController?.close();
  }

  Future<Cocktail> fetchCocktailById(String id) async {
    _cocktailStreamController.add(null);
    Cocktail result;

    final url = '${AsyncCocktailRepository.baseUrl}/lookup.php?i=$id';
    var response = await http.get(
      url,
      headers: AsyncCocktailRepository.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var drinks = jsonResponse['drinks'] as Iterable<dynamic>;
      final dto = CocktailDto.fromJson(drinks.first);
      result = Cocktail.fromDto(dto);
      _cocktailStreamController.add(result);
    } else {
      _cocktailStreamController.addError('Status code ${response.statusCode}');
    }

    return result;
  }
}
