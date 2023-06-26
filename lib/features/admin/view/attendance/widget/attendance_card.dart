// import 'dart:collection';
// import 'package:biren_kocluk/product/model/attendance_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class AttendanceCard extends StatefulWidget {
//   const AttendanceCard({
//     super.key,
//     required this.snapshot,
//     required this.index,
//   });

//   final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
//   final int index;

//   @override
//   State<AttendanceCard> createState() => _AttendanceCardState();
// }

// class _AttendanceCardState extends State<AttendanceCard> {
//   late DateTime _focusedDay;
//   late DateTime _firstDay;
//   late DateTime _lastDay;
//   late DateTime _selectedDay;
//   late Map<DateTime, List<AttendanceModel>> _events;

//   int getHashCode(DateTime key) {
//     return key.day * 1000000 + key.month * 10000 + key.year;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _events = LinkedHashMap(
//       equals: isSameDay,
//       hashCode: getHashCode,
//     );
//     _focusedDay = DateTime.now();
//     _firstDay = DateTime.now().subtract(const Duration(days: 1000));
//     _lastDay = DateTime.now().add(const Duration(days: 1000));
//     _selectedDay = DateTime.now();
//     _loadFirestoreEvents();
//   }

//   _loadFirestoreEvents() async {
//     final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
//     final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
//     _events = {};

//     final snap = await FirebaseFirestore.instance
//         .collection('events')
//         .where('date', isGreaterThanOrEqualTo: firstDay)
//         .where('date', isLessThanOrEqualTo: lastDay)
//         .withConverter(
//             fromFirestore: AttendanceModel.fromFirestore,
//             toFirestore: (event, options) => event.toFirestore())
//         .get();
//     for (var doc in snap.docs) {
//       final event = doc.data();
//       final day =
//           DateTime.utc(event.date.year, event.date.month, event.date.day);
//       if (_events[day] == null) {
//         _events[day] = [];
//       }
//       _events[day]!.add(event);
//     }
//     setState(() {});
//   }

//   List<AttendanceModel> _getEventsForTheDay(DateTime day) {
//     return _events[day] ?? [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// class EventItem extends StatelessWidget {
//   final AttendanceModel event;
//   final Function() onDelete;
//   final Function()? onTap;
//   const EventItem({
//     Key? key,
//     required this.event,
//     required this.onDelete,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         event.status,
//       ),
//       subtitle: Text(
//         event.date.toString(),
//       ),
//       onTap: onTap,
//       trailing: IconButton(
//         icon: const Icon(Icons.delete),
//         onPressed: onDelete,
//       ),
//     );
//   }
// }
