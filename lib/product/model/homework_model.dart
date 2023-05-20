// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Homework {
  final String lesson;
  final DateTime date;
  final topic;
  final String id;
  Homework({
    required this.date,
    required this.lesson,
    required this.topic,
    required this.id,
  });

  factory Homework.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Homework(
      date: data['date'].toDate(),
      lesson: data['subject'],
      topic: data['topic'],
      id: snapshot.id,
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "subject": lesson,
      "topic": topic,
      "id": id,
    };
  }
}
