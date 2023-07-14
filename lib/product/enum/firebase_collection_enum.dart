import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  admin,
  students,
  announcement,
  attendance,
  homeworks,
  homeworkPush,
  exams,
  classes;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
