import 'package:flutter/material.dart';

class AnnouncementHistoryView extends StatelessWidget {
  const AnnouncementHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  AppBar _appBar() => AppBar(title: const Text("Geçmiş Duyurular"));
}
