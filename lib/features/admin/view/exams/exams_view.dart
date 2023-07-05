import 'package:biren_kocluk/features/admin/view/exams/all_exams_view.dart';
import 'package:biren_kocluk/features/admin/view/exams/enter_exams_view.dart';
import 'package:biren_kocluk/features/admin/view/exams/search_exam_result_view.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/admin_features_select_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
      title: Text(LocaleKeys.features_exams.tr()),
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
        child: Column(
          children: [
            SelectFeatureListTile(
              icon: Icons.edit_note_rounded,
              title: LocaleKeys.features_enterResult.tr(),
              subtitle: LocaleKeys
                  .featureDescriptions_enterExamResultDescription
                  .tr(),
              callView: const EnterExamsView(),
            ),
            SelectFeatureListTile(
              icon: Icons.source_rounded,
              title: LocaleKeys.features_showExamResults.tr(),
              subtitle: LocaleKeys
                  .featureDescriptions_showExamResultsDescription
                  .tr(),
              callView: const AllExamsView(),
            ),
            SelectFeatureListTile(
              icon: Icons.account_circle_rounded,
              title: LocaleKeys.features_searchResult.tr(),
              subtitle:
                  LocaleKeys.featureDescriptions_searchResultDescription.tr(),
              callView: const SearchExamResultView(),
            ),
          ],
        ),
      ),
    );
  }
}
