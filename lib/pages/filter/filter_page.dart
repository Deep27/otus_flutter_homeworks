import 'package:cocktaildbhttpusing/pages/filter/widgets/cocktail_type_filter.dart';
import 'package:cocktaildbhttpusing/pages/filter/widgets/seach_field.dart';
import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_definition.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/repository/query_status.dart';
import 'package:cocktaildbhttpusing/src/repository/response.dart';
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
                  final response =
                      snapshot.data as Response<List<CocktailDefinition>>;
                  if (response.status == QueryStatus.success) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: (snapshot.data
                                  as Response<List<CocktailDefinition>>)
                              .response
                              .map((cd) => Text(cd.name))
                              .toList(),
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Expanded(child: Center(child: Text(snapshot.error)));
                } else {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
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
