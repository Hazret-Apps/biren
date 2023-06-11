import 'package:biren_kocluk/features/admin/view/history/announcement_log_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/incoming_homeworks_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "Geçmiş Duyurular",
      "Geçmiş Ödevler",
    ];

    final List<Widget> itemWidgets = [
      const AnnouncementLogView(),
      const IncomingHomeworksView(),
    ];

    void callView(context, int index) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => itemWidgets[index],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Geçmiş"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            titleTextStyle: context.textTheme.titleMedium,
            onTap: () {
              callView(context, index);
            },
            trailing: IconButton(
              onPressed: () {
                callView(context, index);
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
