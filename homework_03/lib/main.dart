import 'package:flutter/material.dart';
import 'package:homework/res/res.dart';

import 'pages/cocktail_detail/cocktail_detail_page.dart';
import 'models/src/repository/sync_cocktail_repository.dart';

void main() {
  final cocktail = SyncCocktailRepository().getHomeworkCocktail();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: buildAppIconTheme(),
        textTheme: buildAppTextTheme(),
      ),
      home: Material(
        child: CocktailDetailPage(cocktail),
      ),
    ),
  );
}
