import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_definition.dart';
import 'package:flutter/material.dart';

class CocktailsGrid {
  CocktailsGrid(this.cocktails);

  final List<CocktailDefinition> cocktails;

  SliverPadding get sliver => SliverPadding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => _Item(cocktails[i]),
          ),
        ),
      );
}

class _Item extends StatelessWidget {
  _Item(this.cocktailDefinition, {Key key}) : super(key: key);

  final CocktailDefinition cocktailDefinition;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: <Widget>[
            Container(
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(cocktailDefinition.drinkThumbUrl),
                ),
              ),
            ),
            // @TODO возникает ошибка 'Incorrect use of ParentDataWidget'
            // @TODO Typically, Positioned widgets are placed directly inside Stack widgets
            // @TODO разместить LayoutBuilder над Stack правильно не выходит
            LayoutBuilder(builder: (ctx, constraints) {
              return Positioned(
                bottom: 0.0,
                left: 0.0,
                right: constraints.maxWidth,
                child: _CocktailInfo(cocktailDefinition),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _CocktailInfo extends StatelessWidget {
  _CocktailInfo(this.cocktailDefinition, {Key key}) : super(key: key);

  final CocktailDefinition cocktailDefinition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cocktailDefinition.name,
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(width: 1.0, color: AppColors.aBorderColor),
              color: AppColors.aFilterItemBgColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              child: Text(
                'id: ${cocktailDefinition.id}',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
