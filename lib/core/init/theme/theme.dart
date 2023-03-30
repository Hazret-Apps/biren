import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';

class LightTheme {
  late ThemeData theme;

  LightTheme() {
    theme = ThemeData(
      scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        foregroundColor: LightThemeColors.white,
        backgroundColor: LightThemeColors.blazeOrange,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
