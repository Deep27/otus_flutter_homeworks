import 'package:cocktaildbhttpusing/pages/filter/widgets/cocktail_type_filter.dart';
import 'package:cocktaildbhttpusing/pages/filter/widgets/seach_field.dart';
import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_category_service.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  final _cocktailCategoryService = CocktailCategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.aBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SearchField(),
            CocktailTypeFilter(CocktailCategory.values),
            StreamBuilder(
              stream: _cocktailCategoryService.onCocktailReceiveEvent,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Expanded(
                    child: Center(
                      child: Text('No category chosen'),
                    ),
                  );
                } else if (snapshot.hasData) {
                } else if (snapshot.hasError) {
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
