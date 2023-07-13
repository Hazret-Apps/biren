import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
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
      uid: data[FirestoreFieldConstants.uidField],
      status: data[FirestoreFieldConstants.statusField],
      date: data[FirestoreFieldConstants.dateField].toDate(),
      name: data[FirestoreFieldConstants.nameField],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      FirestoreFieldConstants.dateField: Timestamp.fromDate(date),
      FirestoreFieldConstants.uidField: uid,
      FirestoreFieldConstants.nameField: name,
      FirestoreFieldConstants.statusField: status,
    };
  }
}
