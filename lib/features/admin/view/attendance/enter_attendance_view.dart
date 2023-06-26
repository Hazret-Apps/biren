import 'dart:collection';
import 'package:biren_kocluk/product/constants/app_constants.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/attendance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:table_calendar/table_calendar.dart';

class EnterAttendanceView extends StatefulWidget {
  const EnterAttendanceView(
      {super.key, required this.snapshot, required this.index});

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<EnterAttendanceView> createState() => _EnterAttendanceViewState();
}

class _EnterAttendanceViewState extends State<EnterAttendanceView> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late Map<DateTime, List<AttendanceModel>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    final snap = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: firstDay)
        .where('date', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: AttendanceModel.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.date.year, event.date.month, event.date.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
    setState(() {});
  }

  List<AttendanceModel> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              child: TableCalendar(
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle:
                      context.textTheme.titleMedium!.copyWith(fontSize: 12),
                  weekdayStyle:
                      context.textTheme.titleMedium!.copyWith(fontSize: 12),
                ),
                locale: AppConstants.TR_LANG,
                eventLoader: _getEventsForTheDay,
                focusedDay: _focusedDay,
                firstDay: _firstDay,
                lastDay: _lastDay,
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                  _loadFirestoreEvents();
                },
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  defaultTextStyle: context.textTheme.titleMedium!,
                  outsideTextStyle: context.textTheme.titleMedium!.copyWith(
                    color: LightThemeColors.grey,
                  ),
                  weekendTextStyle: context.textTheme.titleMedium!,
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LightThemeColors.blazeOrange.withOpacity(.6),
                  ),
                  selectedDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: LightThemeColors.blazeOrange,
                  ),
                ),
              ),
            ),
            ..._getEventsForTheDay(_selectedDay).map(
              (event) => EventItem(
                event: event,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(widget.snapshot.data!.docs[widget.index]["name"]),
    );
  }
}

class EventItem extends StatelessWidget {
  final AttendanceModel event;
  final Function()? onTap;
  const EventItem({
    Key? key,
    required this.event,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        event.status,
      ),
      subtitle: Text(
        event.date.toString(),
      ),
      onTap: onTap,
    );
  }
}
