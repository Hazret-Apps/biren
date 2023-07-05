import 'package:biren_kocluk/features/admin/view/attendance/mixin/enter_attendance_operation_mixin.dart';
import 'package:biren_kocluk/product/constants/app_constants.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/attendance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:table_calendar/table_calendar.dart';

class EnterAttendanceView extends StatefulWidget {
  const EnterAttendanceView({
    super.key,
    required this.snapshot,
    required this.index,
  });

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<EnterAttendanceView> createState() => _EnterAttendanceViewState();
}

class _EnterAttendanceViewState extends State<EnterAttendanceView>
    with EnterAttendanceOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _takeAttendanceButton(context),
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _card(context),
              ...getEventsForTheDay(selectedDay).map(
                (event) => EventItem(
                  event: event,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(widget.snapshot.data!.docs[widget.index]["name"]),
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
        eventLoader: getEventsForTheDay,
        focusedDay: focusedDay,
        firstDay: firstDay,
        lastDay: lastDay,
        onPageChanged: (newFocusedDay) {
          setState(() {
            focusedDay = newFocusedDay;
          });
          loadFirestoreEvents();
        },
        selectedDayPredicate: (day) => isSameDay(day, selectedDay),
        onDaySelected: (newSelectedDay, newFocusedDay) {
          setState(() {
            selectedDay = newSelectedDay;
            focusedDay = newFocusedDay;
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

  FloatingActionButton _takeAttendanceButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        callTakeAttendanceView();
      },
      child: const Icon(Icons.add),
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
        status = LocaleKeys.came.tr();
        color = LightThemeColors.green;
        break;
      case "didntCame":
        status = LocaleKeys.didntCame.tr();
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
