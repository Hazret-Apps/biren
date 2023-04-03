import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LightTheme {
  late ThemeData theme;

  LightTheme(BuildContext context) {
    theme = ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.orange,
      primaryColor: LightThemeColors.white,
      splashColor: LightThemeColors.blazeOrange,
      focusColor: LightThemeColors.blazeOrange,
      shadowColor: LightThemeColors.blazeOrange,
      indicatorColor: LightThemeColors.blazeOrange,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LightThemeColors.snowbank,
        border: OutlineInputBorder(
          borderRadius: context.normalBorderRadius,
          borderSide: BorderSide.none,
        ),
      ),
      scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,
      hoverColor: LightThemeColors.blazeOrange,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        foregroundColor: LightThemeColors.blazeOrange,
        backgroundColor: LightThemeColors.scaffoldBackgroundColor,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: LightThemeColors.blazeOrange,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: LightThemeColors.blazeOrange,
        foregroundColor: LightThemeColors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith(
            (states) {
              return Colors.orange.shade100;
            },
          ),
        ),
      ),
    );
  }
}
