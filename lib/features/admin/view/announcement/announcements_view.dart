import 'package:biren_kocluk/features/admin/view/announcement/add_announcement_view.dart';
import 'package:biren_kocluk/features/admin/view/announcement/announcement_history_view.dart';
import 'package:biren_kocluk/product/widget/card/admin_features_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: const _Body(),
    );
  }

  AppBar get _appBar => AppBar(title: const Text("Duyurular"));
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
              title: "Duyuru Oluştur",
              subtitle: "Öğrencilere bir duyuru yapın",
              icon: Icons.add_circle_outline_rounded,
              callView: CreateAnnouncementView(),
            ),
            SelectFeatureListTile(
              title: "Geçmiş Duyurular",
              subtitle: "Geçmişte yaptığınız duyurular",
              icon: Icons.history_rounded,
              callView: AnnouncementHistoryView(),
            ),
          ],
        ),
      ),
    );
  }
}
