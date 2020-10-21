import 'package:flutter/material.dart';
import 'package:homework/models/models.dart';
import 'package:homework/res/app_icons.dart';
import 'package:homework/res/colors.dart';

class CocktailInfo extends StatelessWidget {
  CocktailInfo(this.cocktail);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textBgColor,
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Title(cocktail),
          SizedBox(height: 8.0),
          _InfoItem('Категория коктейля', cocktail.category.name),
          _InfoItem('Тип коктейля', cocktail.cocktailType.name),
          _InfoItem('Тип стекла', cocktail.glassType.name),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  _Title(this.cocktail);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                cocktail.name,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 8.0),
              Text(
                'id:${cocktail.id}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        const Icon(AppIcons.like_fill),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  _InfoItem(this.title, this.info);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title),
          SizedBox(height: 4.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Container(
              color: AppColors.textTagBgColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                child: Text(info),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
