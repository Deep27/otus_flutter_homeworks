import 'package:flutter/material.dart';
import 'package:homework/models/models.dart';
import 'package:homework/res/colors.dart';

class Instructions extends StatelessWidget {
  Instructions(this.cocktail);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textBgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text('Инструкция для приготовления'),
            ),
            SizedBox(height: 16.0),
            ...cocktail.instruction
                .split('\n')
                .map((s) => Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        right: 24.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 32.0,
                            child: Center(child: const Text('•')),
                          ),
                          Expanded(child: Text(s.replaceAll('- ', ''))),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
