import 'package:biren_kocluk/features/admin/view/homework/incoming_homeworks_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/create_homework_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/admin_all_homework_view.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/admin_features_select_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
      title: Text(LocaleKeys.homework.tr()),
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
              icon: Icons.add_circle_outline_rounded,
              title: LocaleKeys.features_createHomework.tr(),
              subtitle:
                  LocaleKeys.featureDescriptions_createHomeworkDescription.tr(),
              callView: const CreateHomeworkView(),
            ),
            SelectFeatureListTile(
              icon: Icons.warning_amber_rounded,
              title: LocaleKeys.features_incomingHomeworks.tr(),
              subtitle: LocaleKeys
                  .featureDescriptions_incomingHomeworksDescription
                  .tr(),
              callView: const IncomingHomeworksView(),
            ),
            SelectFeatureListTile(
              icon: Icons.all_inbox_rounded,
              title: LocaleKeys.features_allHomeworks.tr(),
              subtitle:
                  LocaleKeys.featureDescriptions_allHomeworksDescription.tr(),
              callView: const AdminAllHomeworksView(),
            ),
          ],
        ),
      ),
    );
  }
}
