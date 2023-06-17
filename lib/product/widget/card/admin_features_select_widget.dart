import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SelectFeatureListTile extends StatelessWidget {
  const SelectFeatureListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.callView,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget callView;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: LightThemeColors.blazeOrangeLight,
      shape: RoundedRectangleBorder(
        borderRadius: context.lowBorderRadius,
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        titleTextStyle: context.textTheme.bodyMedium,
        subtitleTextStyle: context.textTheme.bodyLarge,
        leading: Icon(
          icon,
          size: 30,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        textColor: LightThemeColors.white,
        iconColor: LightThemeColors.white,
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => callView,
            ),
          );
        },
      ),
    );
  }
}
