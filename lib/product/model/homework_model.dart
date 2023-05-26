// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Homework {
  final String lesson;
  final DateTime date;
  final String userOrClass;
  final topic;
  Homework({
    required this.date,
    required this.lesson,
    required this.topic,
    required this.userOrClass,
  });

  factory Homework.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Homework(
      date: data['date'].toDate(),
      lesson: data['subject'],
      topic: data['topic'],
      userOrClass: data['userOrClass'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "subject": lesson,
      "topic": topic,
    };
  }
}
