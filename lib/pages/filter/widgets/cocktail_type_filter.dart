import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:flutter/material.dart';

class CocktailTypeFilter extends StatelessWidget {
  CocktailTypeFilter(Iterable<CocktailCategory> cocktailCategories, {Key key})
      : cocktailCategories =
            cocktailCategories?.map((c) => _Item(c.name))?.toList(),
        super(key: key);

  final List<_Item> cocktailCategories;

  @override
  Widget build(BuildContext context) {
    // @TODO без указания констрейнтов не компилится
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: 40.0,
      ),
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                cocktailCategories?.length,
                (i) => cocktailCategories[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatefulWidget {
  _Item(this.text, {Key key}) : super(key: key);

  final String text;

  @override
  _ItemState createState() => _ItemState(text);
}

class _ItemState extends State<_Item> {
  _ItemState(this.text);

  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(width: 1.0, color: AppColors.aBorderColor),
        color: AppColors.aFilterItemBgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
