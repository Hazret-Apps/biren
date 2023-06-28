import 'package:biren_kocluk/features/admin/view/exams/all_exams_view.dart';
import 'package:biren_kocluk/features/admin/view/exams/enter_exams_view.dart';
import 'package:biren_kocluk/features/admin/view/exams/search_exam_result_view.dart';
import 'package:biren_kocluk/product/widget/card/admin_features_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ExamsView extends StatelessWidget {
  const ExamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: const _Body(),
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: const Text("Denemeler"),
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
              icon: Icons.edit_note_rounded,
              title: "Sonuç Gir",
              subtitle: "Öğrencilerin deneme sonuçlarını gir",
              callView: EnterExamsView(),
            ),
            SelectFeatureListTile(
              icon: Icons.source_rounded,
              title: "Sınav Sonuçlarını Gör",
              subtitle: "Öğrencilerin deneme sonuçlarını gör",
              callView: AllExamsView(),
            ),
            SelectFeatureListTile(
              icon: Icons.account_circle_rounded,
              title: "Sonuç Ara",
              subtitle: "Bir öğrencinin deneme sonuçlarını gör",
              callView: SearchExamResultView(),
            ),
          ],
        ),
      ),
    );
  }
}
