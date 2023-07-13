import 'package:biren_kocluk/features/admin/view/attendance/attendance_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin AdminAttendanceOperationMixin on State<AdminAttendanceView> {
  final Stream<QuerySnapshot<Object?>> stream = FirebaseCollections
      .students.reference
      .where(FirestoreFieldConstants.isVerifiedField, isEqualTo: true)
      .snapshots();

  final currentDate = DateTime.now();
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('dd MMMM', 'tr_TR').format(currentDate);
  }
}
