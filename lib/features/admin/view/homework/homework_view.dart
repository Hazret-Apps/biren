import 'package:biren_kocluk/features/admin/view/history/homeworks_log_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/create_homework_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/homework_search_view.dart';
import 'package:biren_kocluk/features/home/view/homeworks/homework_history.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeworkView extends StatelessWidget {
  const HomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: const _Body(),
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: const Text("Ödev"),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: context.horizontalPaddingLow,
        child: const Column(
          children: [
            _SelectFeatureListTile(
              icon: Icons.add_circle_outline_rounded,
              title: "Ödev Oluştur",
              subtitle: "Öğrenciler için ödev oluştur",
              callView: CreateHomeworkView(),
            ),
            _SelectFeatureListTile(
              icon: Icons.warning_amber_rounded,
              title: "Gelen Ödevler",
              subtitle: "Öğrencilerin gönderdiği ödevler",
              callView: HomeworksLogView(),
            ),
            _SelectFeatureListTile(
              icon: Icons.history_rounded,
              title: "Geçmiş Ödevler",
              subtitle: "Geçmişte verdiğiniz ödevler",
              callView: HomeworkHistory(),
            ),
            _SelectFeatureListTile(
              icon: Icons.account_circle_rounded,
              title: "Ödev Ara",
              subtitle: "Bir öğrenciye verdiğiniz ödevleri arayın",
              callView: HomeworkSearchView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectFeatureListTile extends StatelessWidget {
  const _SelectFeatureListTile({
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
        titleTextStyle: context.textTheme.titleMedium,
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
