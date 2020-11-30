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
// @TODO висит только надпись 'Loading'

class FilterPage extends StatefulWidget {
  final _cocktailCategoryService = CocktailCategoryService();

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    widget._cocktailCategoryService
        .fetchCocktailsByCocktailCategory(CocktailCategory.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.aBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SearchField(),
//            CocktailTypeFilter(
//              widget._cocktailCategoryService,
//              CocktailCategory.values.toList(),
//            ),
            Expanded(
              child: StreamBuilder(
                stream: widget._cocktailCategoryService.onCocktailReceiveEvent,
                builder: (context, snapshot) {
                  return CustomScrollView(
                    slivers: [
                      CocktailTypeFilter(
                        widget._cocktailCategoryService,
                        CocktailCategory.values.toList(),
                      ).sliver,
                    ],
                  );
//                if (snapshot.hasData) {
//                  if (snapshot.data is List<CocktailDefinition>) {
//                    final response = snapshot.data as List<CocktailDefinition>;
//                    return Expanded(
//                      child: CocktailsGrid(response),
//                    );
//                  } else {
//                    if (snapshot.data is String) {
//                      return Expanded(
//                        child: Center(child: Text(snapshot.data)),
//                      );
//                    } else {
//                      return Expanded(
//                          child: Center(child: Text('Unknown error')));
//                    }
//                  }
//                } else if (snapshot.hasError) {
//                  return Expanded(child: Center(child: Text(snapshot.error)));
//                } else {
//                  return Expanded(
//                    child: Center(child: Loading()),
//                  );
//                }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
