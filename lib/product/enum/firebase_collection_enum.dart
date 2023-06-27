import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
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
