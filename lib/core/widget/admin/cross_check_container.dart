import 'package:biren_kocluk/core/enum/cross_check_enum.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CrossTickContainer extends StatelessWidget {
  const CrossTickContainer(
      {super.key, required this.onTap, required this.crossTickEnum});

  final VoidCallback onTap;
  final CrossTickEnum crossTickEnum;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: context.lowBorderRadius,
          border: Border.all(
            color: LightThemeColors.grey,
          ),
        ),
        child: Icon(
          crossTickEnum == CrossTickEnum.cross ? Icons.close : Icons.check,
          size: 16,
          color: crossTickEnum == CrossTickEnum.cross
              ? LightThemeColors.red
              : LightThemeColors.green,
        ),
      ),
    );
  }
}
