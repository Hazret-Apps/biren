import 'package:biren_kocluk/features/admin/view/students/login_requiest_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

mixin LoginRequiestOperationMixin on State<LoginRequiestView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.students.reference
      .where("isVerified", isEqualTo: false)
      .snapshots();

  String name(snapshot, index) => snapshot.data!.docs[index]["name"];
  String mail(snapshot, index) => snapshot.data!.docs[index]["mail"];
  String password(snapshot, index) => snapshot.data!.docs[index]["password"];
  Timestamp createdTime(snapshot, index) =>
      snapshot.data!.docs[index]["createdTime"];
  bool isVerified(snapshot, index) => snapshot.data!.docs[index]["isVerified"];
  String uid(snapshot, index) => snapshot.data!.docs[index]["uid"];
  String classText(snapshot, index) => snapshot.data!.docs[index]["class"];
  String grade(snapshot, index) => snapshot.data!.docs[index]["grade"];

  void deleteUser(snapshot, index) {
    FirebaseCollections.students.reference.doc(uid(snapshot, index)).delete();
  }
}
