import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_category_service.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_definition_service.dart';
import 'package:flutter/material.dart';

class CocktailTypesFilter {
  final _cocktailDefinitionService = CocktailDefinitionService();
  final _cocktailCategoryService = CocktailCategoryService();

  SliverToBoxAdapter get sliver => SliverToBoxAdapter(
        child: Container(
          height: 53,
          child: StreamBuilder(
            stream: _cocktailDefinitionService.onCocktailDefinitionReceiveEvent,
            builder: (ctx, snapshot) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _cocktailCategoryService.cocktailCategories == null
                    ? 0
                    : _cocktailCategoryService.cocktailCategories.length,
                itemBuilder: (ctx, i) {
                  final category =
                      _cocktailCategoryService.cocktailCategories[i];
                  return _Item(
                    category: category,
                    enabled: snapshot.data != null || snapshot.hasError,
                    tappedNotifier: _cocktailCategoryService.tappedCategory,
                    onTap: () => _cocktailDefinitionService
                        .fetchCocktailDefinitionsByCocktailCategory(category),
                  );
                },
              );
            },
          ),
        ),
      );
}

class _Item extends StatelessWidget {
  _Item(
      {@required this.category,
      @required this.enabled,
      @required this.tappedNotifier,
      @required this.onTap,
      Key key})
      : super(key: key);

  final CocktailCategory category;
  final bool enabled;
  final ValueNotifier tappedNotifier;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : () {},
      child: ValueListenableBuilder(
        valueListenable: tappedNotifier,
        builder: (_, v, __) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(width: 1.0, color: AppColors.aBorderColor),
              color: v == category
                  ? AppColors.aActiveFilterItemBgColor
                  : AppColors.aFilterItemBgColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              child: Text(
                category.name,
                style: enabled
                    ? Theme.of(context).textTheme.headline2
                    : Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: AppColors.aHintColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
