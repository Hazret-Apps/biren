import 'dart:collection';
import 'package:biren_kocluk/features/admin/view/attendance/take_attendance_view.dart';
import 'package:biren_kocluk/product/constants/app_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:table_calendar/table_calendar.dart';

class EnterAttendanceView extends StatefulWidget {
  const EnterAttendanceView({
    super.key,
    required this.name,
    required this.uid,
    // required this.snapshot,
    // required this.index,
  });

  // final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  // final int index;
  final String name;
  final String uid;

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

    final snap = await FirebaseCollections.attendance.reference
        .where("uid", isEqualTo: widget.uid)
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => TakeAttendanceView(
                firstDate: _firstDay,
                lastDate: _lastDay,
                selectedDate: _selectedDay,
                name: widget.name,
                uid: widget.uid,
                // snapshot: widget.snapshot,
                // index: widget.index,
              ),
            ),
          );
          if (result ?? false) {
            _loadFirestoreEvents();
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: _appBar(),
      body: SafeArea(
        child: ListView(
          children: [
            _card(context),
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

  Card _card(BuildContext context) {
    return Card(
      child: TableCalendar(
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: context.textTheme.titleMedium!.copyWith(fontSize: 12),
          weekdayStyle: context.textTheme.titleMedium!.copyWith(fontSize: 12),
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
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(widget.uid),
    );
  }
}

class EventItem extends StatelessWidget {
  const EventItem({Key? key, required this.event}) : super(key: key);

  final AttendanceModel event;

  @override
  Widget build(BuildContext context) {
    String? status;
    Color? color;

    switch (event.status) {
      case "came":
        status = "Geldi";
        color = LightThemeColors.green;
        break;
      case "didntCame":
        status = "Gelmedi";
        color = LightThemeColors.red;
        break;
      default:
    }
    return ListTile(
      title: Text(
        DateFormat('dd/MM/yyyy').format(
          event.date,
        ),
      ),
      subtitle: Text(
        status!,
        style: TextStyle(color: color),
      ),
    );
  }
}
