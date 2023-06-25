import 'package:biren_kocluk/features/admin/view/homework/admin_all_homework_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

mixin AdminAllHomeworksOperationMixin on State<AdminAllHomeworksView> {
  final Stream<QuerySnapshot> stream =
      FirebaseCollections.homeworks.reference.snapshots();
}
