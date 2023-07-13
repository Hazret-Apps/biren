import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/home/view/homeworks/missing_homeworks_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin MissingHomeworksOperationMixin on State<MissingHomeworksView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.homeworks.reference
      .where(FirestoreFieldConstants.makeEnumField, isEqualTo: "missing")
      .where(
        Filter.or(
          Filter(
            FirestoreFieldConstants.assignedIdField,
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          ),
          Filter(
            FirestoreFieldConstants.assignedIdField,
            isEqualTo: AuthService.userClassId,
          ),
        ),
      )
      .snapshots();
}
