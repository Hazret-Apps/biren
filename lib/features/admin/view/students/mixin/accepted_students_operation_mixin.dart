import 'package:biren_kocluk/features/admin/view/students/accepted_students_view.dart';
import 'package:biren_kocluk/features/admin/view/students/student_edit_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

mixin AcceptedStudentsOperationMixin on State<AcceptedStudentsView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.students.reference
      .where("isVerified", isEqualTo: true)
      .snapshots();

  String name(snapshot, index) => snapshot.data!.docs[index]["name"];

  void callStudentEditView(BuildContext context,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => StudentEditView(
          userModel: UserModel(
            grade: snapshot.data!.docs[index]["grade"],
            classText: snapshot.data!.docs[index]["class"],
            name: snapshot.data!.docs[index]["name"],
            mail: snapshot.data!.docs[index]["mail"],
            password: snapshot.data!.docs[index]["password"],
            createdTime: snapshot.data!.docs[index]["createdTime"],
            isVerified: snapshot.data!.docs[index]["isVerified"],
            uid: snapshot.data!.docs[index]["uid"],
          ),
        ),
      ),
    );
  }
}
