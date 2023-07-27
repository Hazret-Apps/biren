import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  admin,
  students,
  announcement,
  attendance,
  homeworks,
  exams,
  showcase,
  classes;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
