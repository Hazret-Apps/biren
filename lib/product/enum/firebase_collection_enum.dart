import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  students,
  announcement,
  homeworks,
  homeworkPush,
  exams,
  classes;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
