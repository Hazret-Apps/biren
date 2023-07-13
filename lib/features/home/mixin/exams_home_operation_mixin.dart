import 'package:biren_kocluk/features/home/view/exams/exams_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin ExamsHomeOperationMixin on State<ExamsView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.exams.reference
      .where(FirestoreFieldConstants.studentField,
          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}
