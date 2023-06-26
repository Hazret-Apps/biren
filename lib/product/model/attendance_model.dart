import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class AttendanceModel {
  final String status;
  final String user;
  final DateTime date;

  const AttendanceModel({
    required this.status,
    required this.user,
    required this.date,
  });

  factory AttendanceModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return AttendanceModel(
      user: data["user"],
      status: data["status"],
      date: data['date'].toDate(),
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "user": user,
      "status": status,
    };
  }
}
