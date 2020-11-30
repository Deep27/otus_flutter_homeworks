import 'package:cocktaildbhttpusing/res/colors.dart';

import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_category_service.dart';
import 'package:flutter/material.dart';

class CocktailTypeFilter extends StatelessWidget {
  CocktailTypeFilter(this.cocktailCategoryService,
      Iterable<CocktailCategory> cocktailCategories,
      {Key key})
      : cocktailCategories = cocktailCategories?.toList(),
        super(key: key);

  final _cocktailCategoryService = CocktailCategoryService();
  final CocktailCategoryService cocktailCategoryService;
  final List<CocktailCategory> cocktailCategories;

  @override
  Widget build(BuildContext context) {
    // @TODO без указания констрейнтов не компилится
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: 60.0,
      ),
      child: StreamBuilder(
        stream: cocktailCategoryService.onCocktailReceiveEvent,
        builder: (stream, snapshot) {
          List<_Item> cocktailCategoryItems = cocktailCategories
              ?.map((c) => _Item(
                    category: c,
                    // @TODO проверить, принял ли данные sink (не используя класс Response)
                    // @TODO чтобы все кнопки стали активными
                    enabled: snapshot.data != null,
                    tapped: c == _cocktailCategoryService.tappedCategory,
                    onTap: () => cocktailCategoryService
                        .fetchCocktailsByCocktailCategory(c),
                  ))
              ?.toList();
          return CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(
                    cocktailCategoryItems?.length,
                    (i) => cocktailCategoryItems[i],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
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
