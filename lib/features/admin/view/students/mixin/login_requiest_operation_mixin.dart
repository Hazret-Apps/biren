import 'package:biren_kocluk/features/admin/view/students/login_requiest_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

mixin LoginRequiestOperationMixin on State<LoginRequiestView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.students.reference
      .where(FirestoreFieldConstants.isVerifiedField, isEqualTo: false)
      .snapshots();

  String name(snapshot, index) =>
      snapshot.data!.docs[index][FirestoreFieldConstants.nameField];
  String mail(snapshot, index) =>
      snapshot.data!.docs[index][FirestoreFieldConstants.mailField];
  String password(snapshot, index) =>
      snapshot.data!.docs[index][FirestoreFieldConstants.passwordField];
  Timestamp createdTime(snapshot, index) =>
      snapshot.data!.docs[index][FirestoreFieldConstants.createdTimeField];
  bool isVerified(snapshot, index) =>
      snapshot.data!.docs[index][FirestoreFieldConstants.isVerifiedField];
  String uid(snapshot, index) =>
      snapshot.data!.docs[index][FirestoreFieldConstants.uidField];
  String classText(snapshot, index) =>
      snapshot.data!.docs[index][FirestoreFieldConstants.classField];
  String grade(snapshot, index) =>
      snapshot.data!.docs[index][FirestoreFieldConstants.gradeField];

  void deleteUser(snapshot, index) {
    FirebaseCollections.students.reference.doc(uid(snapshot, index)).delete();
  }
}
