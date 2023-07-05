import 'package:biren_kocluk/features/admin/view/announcement/create_announcement_view.dart';
import 'package:biren_kocluk/features/admin/view/announcement/announcement_history_view.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/admin_features_select_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AnnouncementsViewAdmin extends StatelessWidget {
  const AnnouncementsViewAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: const _Body(),
    );
  }

  AppBar get _appBar =>
      AppBar(title: Text(LocaleKeys.features_announcements.tr()));
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
              title: LocaleKeys.features_createAnnouncement.tr(),
              subtitle:
                  LocaleKeys.featureDescriptions_createHomeworkDescription.tr(),
              icon: Icons.add_circle_outline_rounded,
              callView: const CreateAnnouncementView(),
            ),
            SelectFeatureListTile(
              title: LocaleKeys.features_announcementHistory.tr(),
              subtitle: LocaleKeys
                  .featureDescriptions_announcementHistoryDescription
                  .tr(),
              icon: Icons.history_rounded,
              callView: const AnnouncementHistoryView(),
            ),
          ],
        ),
      ),
    );
  }
}
