import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homework/res/colors.dart';

//const String _bebasFontFamily = 'BebasNeue';

IconThemeData buildAppIconTheme() => IconThemeData(
      color: Colors.white,
      size: 24.0,
    );

TextTheme buildAppTextTheme() => TextTheme(
      headline1: TextStyle(
        fontSize: 24,
        height: 23 / 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
      headline2: TextStyle(
        fontSize: 20,
        height: 22 / 17,
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.41,
      ),
      headline3: TextStyle(
        fontSize: 18,
        height: 20 / 14,
        color: AppColors.ingredientsTitleColor,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.25,
      ),
      headline4: TextStyle(
        fontSize: 14,
        height: 16 / 14,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.75,
      ),
      headline5: TextStyle(
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontStyle: FontStyle.normal,
      ),
      headline6: TextStyle(
        fontSize: 12,
        height: 20 / 12,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w300,
        color: Colors.white,
        fontStyle: FontStyle.normal,
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        letterSpacing: 0.15,
      ),
      subtitle2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.1,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryTextColor,
        letterSpacing: 0.5,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        letterSpacing: 0.25,
      ),
      button: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 1.25,
      ),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        letterSpacing: 0.4,
      ),
      overline: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        letterSpacing: 1.5,
      ),
    );
