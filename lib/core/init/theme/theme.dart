import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';

class LightTheme {
  late ThemeData theme;

  LightTheme() {
    theme = ThemeData(
      primarySwatch: Colors.orange,
      primaryColor: LightThemeColors.white,
      scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,
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
    );
  }
}
