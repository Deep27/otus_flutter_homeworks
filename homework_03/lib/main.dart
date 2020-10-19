import 'package:flutter/material.dart';

import 'pages/cocktail_detail/cocktail_detail_page.dart';
import 'models/src/repository/sync_cocktail_repository.dart';

void main() {
  final cocktail = SyncCocktailRepository().getHomeworkCocktail();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24.0,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      home: Material(
        child: CocktailDetailPage(cocktail),
      ),
    ),
  );
}
