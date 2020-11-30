import 'package:cocktaildbhttpusing/res/colors.dart';

import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_category_service.dart';
import 'package:flutter/material.dart';

class CocktailTypeFilter {
  CocktailTypeFilter(CocktailCategoryService cocktailCategoryService,
      Iterable<CocktailCategory> cocktailCategories,
      {Key key})
      : _cocktailCategoryService = cocktailCategoryService,
        _cocktailCategories = cocktailCategories?.toList();

  final CocktailCategoryService _cocktailCategoryService;
  final List<CocktailCategory> _cocktailCategories;

  SliverToBoxAdapter get sliver => SliverToBoxAdapter(
        child: Container(
          // @TODO не хардкодить высоту
          height: 60,
          child: StreamBuilder(
            stream: _cocktailCategoryService.onCocktailReceiveEvent,
            builder: (ctx, snapshot) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _cocktailCategories == null
                    ? 0
                    : _cocktailCategories.length,
                itemBuilder: (ctx, i) {
                  final category = _cocktailCategories[i];
                  return _Item(
                    category: category,
                    enabled: snapshot.data != null,
                    tapped: category == _cocktailCategoryService.tappedCategory,
                    onTap: () => _cocktailCategoryService
                        .fetchCocktailsByCocktailCategory(category),
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
      @required this.tapped,
      @required this.onTap,
      Key key})
      : super(key: key);

  final CocktailCategory category;
  final bool enabled;
  final bool tapped;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(width: 1.0, color: AppColors.aBorderColor),
          color: tapped
              ? AppColors.aActiveFilterItemBgColor
              : AppColors.aFilterItemBgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
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
      ),
    );
  }
}