// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homework {
  final String lesson;
  final DateTime date;
  final String user;
  final String makeEnum;
  final String? id;
  final topic;

  Homework({
    this.id,
    required this.date,
    required this.lesson,
    required this.topic,
    required this.user,
    required this.makeEnum,
  });

  factory Homework.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Homework(
      date: data[FirestoreFieldConstants.dateField].toDate(),
      lesson: data[FirestoreFieldConstants.subjectField],
      topic: data[FirestoreFieldConstants.topicField],
      user: data[FirestoreFieldConstants.assignedIdField],
      makeEnum: data[FirestoreFieldConstants.makeEnumField],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      FirestoreFieldConstants.dateField: Timestamp.fromDate(date),
      FirestoreFieldConstants.subjectField: lesson,
      FirestoreFieldConstants.topicField: topic,
      FirestoreFieldConstants.makeEnumField: makeEnum,
    };
  }
}
