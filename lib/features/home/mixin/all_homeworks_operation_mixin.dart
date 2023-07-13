import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/home/view/homeworks/all_homeworks_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin AllHomeworksOperationMixin on State<AllHomeworksView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.homeworks.reference
      .where(
        Filter.or(
          Filter(
            "assignedId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          ),
          Filter(
            "assignedId",
            isEqualTo: AuthService.userClassId,
          ),
        ),
      )
      .snapshots();
}
