import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AttendanceHistoryView extends StatefulWidget {
  const AttendanceHistoryView({super.key});

  @override
  State<AttendanceHistoryView> createState() => _AttendanceHistoryViewState();
}

class _AttendanceHistoryViewState extends State<AttendanceHistoryView> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Column(
          children: [
            CalendarTimeline(
              initialDate: selectedDate,
              firstDate: DateTime(2023),
              lastDate: DateTime(2030),
              onDateSelected: (date) {
                selectedDate = date;
              },
              leftMargin: context.width / 2.5,
              monthColor: LightThemeColors.grey,
              dayColor: LightThemeColors.grey,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: LightThemeColors.blazeOrange,
              selectableDayPredicate: (date) => date.day != 23,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(title: const Text("Yoklama Geçmişi"));
}
