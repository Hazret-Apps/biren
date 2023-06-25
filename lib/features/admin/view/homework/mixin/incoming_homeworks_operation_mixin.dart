import 'package:biren_kocluk/features/admin/view/homework/incoming_homeworks_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

mixin IncomingHomeworksOperationMixin on State<IncomingHomeworksView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections
      .homeworkPush.reference
      .where("madeEnum", isEqualTo: "pushed")
      .snapshots();
}
