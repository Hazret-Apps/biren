import 'package:biren_kocluk/features/home/view/homeworks/didnt_made_homeworks_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin DidntMadeOperationMixin on State<DidntMadeHomeworksView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.homeworks.reference
      .where("makeEnum", isEqualTo: "didntMade")
      .where("assignedUserID",
          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}
