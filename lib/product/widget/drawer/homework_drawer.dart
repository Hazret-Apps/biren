import 'package:biren_kocluk/features/home/view/homeworks/homework_history.dart';
import 'package:biren_kocluk/features/home/view/homeworks/pushed_homeworks_view.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeworkDrawer extends StatelessWidget {
  const HomeworkDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: LightThemeColors.blazeOrange,
            ),
            height: context.height / 6,
            child: Padding(
              padding: context.verticalPaddingMedium +
                  context.horizontalPaddingNormal,
              child: Text(
                "Biren Koçluk",
                style: context.textTheme.titleLarge?.copyWith(
                  color: LightThemeColors.white,
                ),
              ),
            ),
          ),
          _HomeworkListTile(
            "Geçmiş Ödevler",
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const HomeworkHistory(),
                ),
              );
            },
            Icons.history,
          ),
          _HomeworkListTile(
            "Yapılmayan Ödevler",
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const HomeworkHistory(),
                ),
              );
            },
            Icons.close_rounded,
          ),
          _HomeworkListTile(
            "Eksik Ödevler",
            () {},
            Icons.remove_circle_outline_rounded,
          ),
          _HomeworkListTile(
            "Gönderilen Ödevler",
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const PushedHomeworksView(),
                ),
              );
            },
            Icons.work_outline_rounded,
          ),
        ],
      ),
    );
  }
}

class _HomeworkListTile extends StatelessWidget {
  const _HomeworkListTile(this.title, this.onTap, this.icon);
  final String title;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
