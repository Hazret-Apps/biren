import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AnnouncementHistoryView extends StatelessWidget {
  const AnnouncementHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  AppBar _appBar() =>
      AppBar(title: Text(LocaleKeys.features_announcementHistory.tr()));
}
