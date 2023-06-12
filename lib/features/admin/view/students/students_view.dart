import 'package:biren_kocluk/features/admin/view/students/accepted_students_view.dart';
import 'package:biren_kocluk/features/admin/view/students/login_requiest_view.dart';
import 'package:biren_kocluk/product/widget/card/admin_features_select_widget.dart';
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

  AppBar _appBar() => AppBar(title: const Text("Öğrenciler"));
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
              icon: Icons.account_circle_rounded,
              title: "Kayıtlı Öğrenciler",
              subtitle: "Kabul edilen öğrenciler",
              callView: AcceptedStudentsView(),
            ),
            SelectFeatureListTile(
              icon: Icons.exit_to_app_rounded,
              title: "Giriş Talepleri",
              subtitle: "Kayıt olma talepleri",
              callView: LoginRequiestView(),
            ),
          ],
        ),
      ),
    );
  }
}
