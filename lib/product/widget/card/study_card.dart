import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StudyCard extends StatelessWidget {
  const StudyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.verticalPaddingNormal,
      child: Container(
        height: context.height * 0.13,
        width: context.width * 0.95,
        decoration: BoxDecoration(
          color: LightThemeColors.grey.withOpacity(.2),
          borderRadius: context.normalBorderRadius,
        ),
      ),
    );
  }
}
