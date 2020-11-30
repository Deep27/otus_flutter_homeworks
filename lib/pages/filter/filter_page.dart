import 'package:cocktaildbhttpusing/pages/common/loading.dart';
import 'package:cocktaildbhttpusing/pages/filter/widgets/cocktail_type_filter.dart';
import 'package:cocktaildbhttpusing/pages/filter/widgets/cocktails_grid.dart';
import 'package:cocktaildbhttpusing/pages/filter/widgets/seach_field.dart';
import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_definition.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_category_service.dart';
import 'package:flutter/material.dart';

// @TODO при запуске приложения экран зависает, помогает hotReload

class FilterPage extends StatelessWidget {
  final _cocktailCategoryService = CocktailCategoryService();

  @override
  Widget build(BuildContext context) {
    _cocktailCategoryService
        .fetchCocktailsByCocktailCategory(CocktailCategory.first);
    return Scaffold(
      backgroundColor: AppColors.aBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SearchField(),
            CocktailTypeFilter(
              _cocktailCategoryService,
              CocktailCategory.values.toList(),
            ),
            StreamBuilder(
              stream: _cocktailCategoryService.onCocktailReceiveEvent,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data is List<CocktailDefinition>) {
                    final response = snapshot.data as List<CocktailDefinition>;
                    return Expanded(
                      child: CocktailsGrid(response),
                    );
                  } else {
                    if (snapshot.data is String) {
                      return Expanded(
                        child: Center(child: Text(snapshot.data)),
                      );
                    } else {
                      return Expanded(child: Center(child: Text('Unknown error')));
                    }
                  }
                } else if (snapshot.hasError) {
                  return Expanded(child: Center(child: Text(snapshot.error)));
                } else {
                  return Expanded(
                    child: Center(child: Loading()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
