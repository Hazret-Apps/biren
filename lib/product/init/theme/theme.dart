import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/init/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LightTheme {
  late ThemeData theme;

  LightTheme(BuildContext context) {
    theme = ThemeData(
      colorScheme: _colorSheme(),
      useMaterial3: true,
      primarySwatch: Colors.orange,
      primaryColor: LightThemeColors.white,
      splashColor: LightThemeColors.blazeOrange,
      focusColor: LightThemeColors.blazeOrange,
      shadowColor: LightThemeColors.blazeOrange,
      indicatorColor: LightThemeColors.blazeOrange,
      inputDecorationTheme: _inputDecoration(context),
      scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,
      hoverColor: LightThemeColors.blazeOrange,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: LightThemeColors.black,
        ),
        backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      ),
      floatingActionButtonTheme: _floatingActionButtonTheme(),
      textButtonTheme: _textButton(),
      textTheme: _textTheme(),
    );
  }

  FloatingActionButtonThemeData _floatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: LightThemeColors.blazeOrange,
      foregroundColor: LightThemeColors.white,
    );
  }

  TextTheme _textTheme() {
    return TextTheme(
      displayLarge: MyTypography.headline1,
      displayMedium: MyTypography.headline2,
      displaySmall: MyTypography.headline3,
      headlineMedium: MyTypography.caption1,
      bodyLarge: MyTypography.body1,
      bodyMedium: MyTypography.body2,
      titleMedium: MyTypography.subhead,
      bodySmall: MyTypography.caption2,
    );
  }

  TextButtonThemeData _textButton() {
    return TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.orange.shade100;
          },
        ),
      ),
    );
  }

  InputDecorationTheme _inputDecoration(BuildContext context) {
    return InputDecorationTheme(
      filled: true,
      fillColor: LightThemeColors.snowbank,
      hintStyle: const TextStyle(
        fontFamily: "Poppins",
        color: LightThemeColors.grey,
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(
        borderRadius: context.lowBorderRadius + context.lowBorderRadius,
        borderSide: BorderSide.none,
      ),
    );
  }

  ColorScheme _colorSheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: LightThemeColors.blazeOrange.withOpacity(.3),
      onPrimary: LightThemeColors.white,
      secondary: LightThemeColors.white,
      onSecondary: LightThemeColors.white,
      error: LightThemeColors.red,
      onError: LightThemeColors.red,
      background: LightThemeColors.scaffoldBackgroundColor,
      onBackground: LightThemeColors.white,
      surface: LightThemeColors.white,
      onSurface: LightThemeColors.black,
    );
  }
}
