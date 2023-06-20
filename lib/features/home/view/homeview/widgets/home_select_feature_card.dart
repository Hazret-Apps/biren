import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';

class SelectFeatureCard extends StatelessWidget {
  const SelectFeatureCard({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
    required this.callView,
  });

  final Color color;
  final String text;
  final Widget icon;
  final Widget callView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => callView,
          ),
        );
      },
      child: Container(
        height: 125,
        width: 125,
        decoration: BoxDecoration(
          color: color,
          borderRadius: context.normalBorderRadius,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(
                4,
                5,
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              text,
              style: const TextStyle(
                color: LightThemeColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
