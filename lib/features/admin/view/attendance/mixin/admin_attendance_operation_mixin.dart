import 'package:biren_kocluk/features/admin/view/attendance/attendance_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

mixin AdminAttendanceOperationMixin on State<AdminAttendanceView> {
  final Stream<QuerySnapshot<Object?>> stream = FirebaseCollections
      .students.reference
      .where("isVerified", isEqualTo: true)
      .snapshots();
}
