import 'package:biren_kocluk/features/admin/view/homework/homeworks_log_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/create_homework_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/homework_search_view.dart';
import 'package:biren_kocluk/features/home/view/homeworks/homework_history.dart';
import 'package:biren_kocluk/product/widget/card/admin_features_select_widget.dart';
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
            SelectFeatureListTile(
              icon: Icons.add_circle_outline_rounded,
              title: "Ödev Oluştur",
              subtitle: "Öğrenciler için ödev oluştur",
              callView: CreateHomeworkView(),
            ),
            SelectFeatureListTile(
              icon: Icons.warning_amber_rounded,
              title: "Gelen Ödevler",
              subtitle: "Öğrencilerin gönderdiği ödevler",
              callView: HomeworksLogView(),
            ),
            SelectFeatureListTile(
              icon: Icons.history_rounded,
              title: "Geçmiş Ödevler",
              subtitle: "Geçmişte verdiğiniz ödevler",
              callView: HomeworkHistory(),
            ),
            SelectFeatureListTile(
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
