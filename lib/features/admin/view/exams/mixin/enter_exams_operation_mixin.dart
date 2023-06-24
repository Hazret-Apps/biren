import 'package:biren_kocluk/features/admin/view/exams/enter_exams_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

mixin EnterExamsOperationMixin on State<EnterExamsView> {
  String? selectedUserValue;

  final Stream<QuerySnapshot> stream = FirebaseCollections.students.reference
      .where("isVerified", isEqualTo: true)
      .snapshots();
}
