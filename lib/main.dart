import 'package:cocktaildbhttpusing/pages/filter/filter_page.dart';
import 'package:cocktaildbhttpusing/src/models.dart';
import 'package:flutter/material.dart';
import 'package:cocktaildbhttpusing/res/styles.dart';

//import 'pages/cocktail_detail/cocktail_detail_page.dart';

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
//        child: CocktailDetailPage(cocktail),
        child: FilterPage(),
      ),
    ),
  );
}
