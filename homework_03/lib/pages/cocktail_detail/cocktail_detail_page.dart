import 'package:flutter/material.dart';
import 'package:homework/models/models.dart';
import 'package:homework/pages/cocktail_detail/widgets/image_header.dart';

class CocktailDetailPage extends StatelessWidget {
  const CocktailDetailPage(
    this.cocktail, {
    Key key,
  }) : super(key: key);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageHeader('assets/images/mohito.jpg'),
              Text('test', style: Theme.of(context).textTheme.bodyText1,),
            ],
          ),
        ),
      ),
    );
  }
}

