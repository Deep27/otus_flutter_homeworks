import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:cocktaildbhttpusing/src/dto/cocktail_definition_dto.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/repository/query_status.dart';
import 'package:cocktaildbhttpusing/src/repository/response.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_category_service.dart';
import 'package:flutter/material.dart';

class CocktailTypeFilter extends StatelessWidget {
  CocktailTypeFilter(this.cocktailCategoryService,
      Iterable<CocktailCategory> cocktailCategories,
      {Key key})
      : cocktailCategories = cocktailCategories?.toList(),
        super(key: key);

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
//          final isNotActive =
//              snapshot.connectionState != ConnectionState.active;
          final hasData = snapshot.hasError ||
              (snapshot.hasData &&
                  ((snapshot.data as Response).status != QueryStatus.waiting));

          List<_Item> cocktailCategoryItems = cocktailCategories
              ?.map((c) => _Item(
                    category: c,
                    enabled: hasData,
                    onTap: () => cocktailCategoryService
                        .fetchCocktailsByCocktailCategory(c),
                  ))
              // @TODO проверить, принял ли данные sink
              // @TODO чтобы все кнопки стали активными
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
      @required this.onTap,
      Key key})
      : super(key: key);

  final CocktailCategory category;
  final bool enabled;
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
          color: AppColors.aFilterItemBgColor,
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
