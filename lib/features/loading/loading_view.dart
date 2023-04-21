import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: LightThemeColors.blazeOrange),
      ),
    );
  }
}
