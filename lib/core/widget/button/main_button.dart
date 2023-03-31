import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: context.normalBorderRadius,
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: context.normalBorderRadius,
          gradient: const LinearGradient(
            colors: [
              LightThemeColors.blazeOrange,
              LightThemeColors.red,
            ],
          ),
        ),
        child: Center(
          child: _text(context),
        ),
      ),
    );
  }

  Text _text(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: LightThemeColors.white),
    );
  }
}
