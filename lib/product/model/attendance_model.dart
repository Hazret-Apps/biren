import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class AttendanceModel {
  final String status;
  final String uid;
  final String name;
  final DateTime date;

  const AttendanceModel({
    required this.status,
    required this.uid,
    required this.date,
    required this.name,
  });

  factory AttendanceModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return AttendanceModel(
      uid: data["uid"],
      status: data["status"],
      date: data['date'].toDate(),
      name: data['name'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "uid": uid,
      "name": name,
      "status": status,
    };
  }
}
