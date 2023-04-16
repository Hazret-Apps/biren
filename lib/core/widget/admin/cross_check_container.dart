import 'package:biren_kocluk/core/enum/cross_check_enum.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CrossOrTickContainer extends StatelessWidget {
  const CrossOrTickContainer({
    super.key,
    required this.crossTickEnum,
    required this.onTap,
  });

  final CrossTickEnum crossTickEnum;
  final VoidCallback onTap;

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
