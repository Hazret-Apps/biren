import 'package:biren_kocluk/features/admin/view/students/accepted_students_view.dart';
import 'package:biren_kocluk/features/admin/view/students/student_edit_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

mixin AcceptedStudentsOperationMixin on State<AcceptedStudentsView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.students.reference
      .where(FirestoreFieldConstants.isVerifiedField, isEqualTo: true)
      .snapshots();

  String name(snapshot, index) =>
      snapshot.data!.docs[index][FirestoreFieldConstants.nameField];

  void callStudentEditView(BuildContext context,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => StudentEditView(
          userModel: UserModel(
            grade: snapshot.data!.docs[index]
                [FirestoreFieldConstants.gradeField],
            parentPhoneNumber: snapshot.data!.docs[index]
                [FirestoreFieldConstants.parentPhoneField],
            studentPhoneNumber: snapshot.data!.docs[index]
                [FirestoreFieldConstants.studentPhoneField],
            classText: snapshot.data!.docs[index]
                [FirestoreFieldConstants.classField],
            name: snapshot.data!.docs[index][FirestoreFieldConstants.nameField],
            mail: snapshot.data!.docs[index][FirestoreFieldConstants.mailField],
            password: snapshot.data!.docs[index]
                [FirestoreFieldConstants.passwordField],
            createdTime: snapshot.data!.docs[index]
                [FirestoreFieldConstants.createdTimeField],
            isVerified: snapshot.data!.docs[index]
                [FirestoreFieldConstants.isVerifiedField],
            uid: snapshot.data!.docs[index][FirestoreFieldConstants.uidField],
          ),
        ),
      ),
    );
  }
}
