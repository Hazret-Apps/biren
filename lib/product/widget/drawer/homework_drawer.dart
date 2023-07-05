import 'package:biren_kocluk/features/home/view/homeworks/all_homeworks_view.dart';
import 'package:biren_kocluk/features/home/view/homeworks/didnt_made_homeworks_view.dart';
import 'package:biren_kocluk/features/home/view/homeworks/missing_homeworks_view.dart';
import 'package:biren_kocluk/features/home/view/homeworks/pushed_homeworks_view.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:easy_localization/easy_localization.dart';
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
                LocaleKeys.appName.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                  color: LightThemeColors.white,
                ),
              ),
            ),
          ),
          _HomeworkListTile(
            LocaleKeys.features_homeworkHistory.tr(),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AllHomeworksView(),
                ),
              );
            },
            Icons.history,
          ),
          _HomeworkListTile(
            LocaleKeys.features_didntMadeHomeworks.tr(),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const DidntMadeHomeworksView(),
                ),
              );
            },
            Icons.close_rounded,
          ),
          _HomeworkListTile(
            LocaleKeys.features_missingHomeworks.tr(),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const MissingHomeworksView(),
                ),
              );
            },
            Icons.remove_circle_outline_rounded,
          ),
          _HomeworkListTile(
            LocaleKeys.features_pushedHomeworks.tr(),
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
