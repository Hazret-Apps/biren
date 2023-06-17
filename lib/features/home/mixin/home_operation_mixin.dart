import 'dart:collection';

import 'package:biren_kocluk/features/home/view/home_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/model/homework_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

mixin HomeOperationMixin on State<HomeView> {
  late DateTime focusedDay;
  late DateTime firstDay;
  late DateTime lastDay;
  late DateTime selectedDay;
  late Map<DateTime, List<Homework>> events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<Homework> getEventsForTheDay(DateTime day) {
    return events[day] ?? [];
  }

  loadFirestoreEvents() async {
    events = {};

    final snap = await FirebaseCollections.homeworks.reference
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .withConverter(
            fromFirestore: Homework.fromFirestore,
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
}
