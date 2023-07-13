import 'dart:collection';
import 'package:biren_kocluk/features/admin/view/attendance/enter_attendance_view.dart';
import 'package:biren_kocluk/features/admin/view/attendance/take_attendance_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/model/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

mixin EnterAttendanceOperationMixin on State<EnterAttendanceView> {
  late DateTime focusedDay;
  late DateTime firstDay;
  late DateTime lastDay;
  late DateTime selectedDay;
  late Map<DateTime, List<AttendanceModel>> events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  loadFirestoreEvents() async {
    final firstDay = DateTime(focusedDay.year, focusedDay.month, 1);
    events = {};

    String uid = widget.snapshot.data!.docs[widget.index]
        [FirestoreFieldConstants.uidField];

    final snap = await FirebaseCollections.attendance.reference
        .where(FirestoreFieldConstants.uidField, isEqualTo: uid)
        .where(FirestoreFieldConstants.dateField,
            isGreaterThanOrEqualTo: firstDay)
        .withConverter(
            fromFirestore: AttendanceModel.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.date.year, event.date.month, event.date.day);
      if (events[day] == null) {
        events[day] = [];
      }
      events[day]!.add(event);
    }
    setState(() {});
  }

  List<AttendanceModel> getEventsForTheDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  void initState() {
    super.initState();
    events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    focusedDay = DateTime.now();
    firstDay = DateTime.now().subtract(const Duration(days: 1000));
    lastDay = DateTime.now().add(const Duration(days: 1000));
    selectedDay = DateTime.now();
    loadFirestoreEvents();
  }

  void callTakeAttendanceView() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => TakeAttendanceView(
          firstDate: firstDay,
          lastDate: lastDay,
          selectedDate: selectedDay,
          snapshot: widget.snapshot,
          index: widget.index,
        ),
      ),
    );
    if (result ?? false) {
      loadFirestoreEvents();
    }
  }
}
