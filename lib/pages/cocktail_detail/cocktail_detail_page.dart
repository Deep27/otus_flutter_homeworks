import 'package:cocktaildbhttpusing/pages/common/loading.dart';
import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:cocktaildbhttpusing/res/ids.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_service.dart';
import 'package:flutter/material.dart';
import 'package:cocktaildbhttpusing/src/models.dart';
import 'package:cocktaildbhttpusing/pages/cocktail_detail/widgets/cocktail_info.dart';
import 'package:cocktaildbhttpusing/pages/cocktail_detail/widgets/cocktail_ingredients.dart';
import 'package:cocktaildbhttpusing/pages/cocktail_detail/widgets/cocktail_rating.dart';
import 'package:cocktaildbhttpusing/pages/cocktail_detail/widgets/image_header.dart';
import 'package:cocktaildbhttpusing/pages/cocktail_detail/widgets/instructions.dart';

class CocktailDetailPage extends StatefulWidget {
  CocktailDetailPage(
    this.cocktailId,
    this.imageUrl, {
    Key key,
  }) : super(key: key);

  final String cocktailId;
  final imageUrl;

  final CocktailService _cocktailService = CocktailService();

  @override
  _CocktailDetailPageState createState() => _CocktailDetailPageState();
}

class _CocktailDetailPageState extends State<CocktailDetailPage> {
  @override
  void initState() {
    widget._cocktailService.fetchCocktailById(widget.cocktailId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: '${Ids.heroCocktailDetails}${widget.cocktailId}',
                child: ImageHeader(widget.imageUrl),
              ),
              StreamBuilder(
                  stream: widget._cocktailService.onCocktailReceiveEvent,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      final cocktail = snapshot.data as Cocktail;
                      return Column(
                        children: [
                          CocktailInfo(cocktail),
                          CocktailIngredients(cocktail),
                          Instructions(cocktail),
                          CocktailRating(cocktail),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error));
                    } else {
                      return const Center(child: Loading());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
