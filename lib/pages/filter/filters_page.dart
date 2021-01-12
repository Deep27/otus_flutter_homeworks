import 'package:cocktaildbhttpusing/pages/common/loading.dart';
import 'package:cocktaildbhttpusing/pages/filter/widgets/seach_field.dart';
import 'package:cocktaildbhttpusing/pages/filter/widgets/slivers/cocktail_types_filter.dart';
import 'package:cocktaildbhttpusing/pages/filter/widgets/slivers/cocktails_grid.dart';
import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_category.dart';
import 'package:cocktaildbhttpusing/src/model/cocktail_definition.dart';
import 'package:cocktaildbhttpusing/src/repository/services/cocktail_definition_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// @TODO при запуске приложения экран зависает, помогает hotReload
// @TODO висит только надпись 'Loading'

class FilterPage extends StatefulWidget {
  final _cocktailDefinitionService = CocktailDefinitionService();

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    widget._cocktailDefinitionService
        .fetchCocktailDefinitionsByCocktailCategory(CocktailCategory.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.aBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              SearchField(),
              Expanded(
                child: StreamBuilder(
                  stream: widget._cocktailDefinitionService
                      .onCocktailDefinitionReceiveEvent,
                  builder: (context, snapshot) {
                    return CustomScrollView(
                      slivers: [
                        CocktailTypesFilter().sliver,
                        _checkSnapshot(snapshot),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _checkSnapshot(AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data is List<CocktailDefinition>) {
        if ((snapshot.data as Iterable).isEmpty) {
          return SliverFillRemaining(child: Center(child: Text('None found')));
        } else {
          return CocktailsGrid(snapshot.data).sliver;
        }
      } else {
        return SliverFillRemaining(
          child: const Center(child: Text('Unknown error')),
        );
      }
    } else if (snapshot.hasError) {
      return SliverFillRemaining(child: Center(child: Text(snapshot.error)));
    } else {
      return SliverFillRemaining(child: const Center(child: Loading()));
    }
  }
}
