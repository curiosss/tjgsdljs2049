import 'package:flutter/material.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SF-Pro-Display',
  useMaterial3: false,
  scaffoldBackgroundColor: AppColors.scaffoldBack,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 8,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.btnRadius),
      ),
    ),
  ),
);
