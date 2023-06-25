import 'package:biren_kocluk/features/home/view/homeworks/missing_homeworks_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin MissingHomeworksOperationMixin on State<MissingHomeworksView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.homeworks.reference
      .where("makeEnum", isEqualTo: "missing")
      .where("assignedUserID",
          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}
