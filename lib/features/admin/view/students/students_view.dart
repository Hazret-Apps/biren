import 'package:biren_kocluk/features/admin/view/students/accepted_students_view.dart';
import 'package:biren_kocluk/features/admin/view/students/login_requiest_view.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/admin_features_select_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StudentsView extends StatelessWidget {
  const StudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const _Body(),
    );
  }

  AppBar _appBar() => AppBar(title: Text(LocaleKeys.features_students.tr()));
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
              icon: Icons.account_circle_rounded,
              title: LocaleKeys.features_registeredStudents.tr(),
              subtitle: LocaleKeys
                  .featureDescriptions_registeredStudentsDescription
                  .tr(),
              callView: const AcceptedStudentsView(),
            ),
            SelectFeatureListTile(
              icon: Icons.exit_to_app_rounded,
              title: LocaleKeys.features_loginRequests.tr(),
              subtitle:
                  LocaleKeys.featureDescriptions_loginRequestsDescription.tr(),
              callView: const LoginRequiestView(),
            ),
          ],
        ),
      ),
    );
  }
}
