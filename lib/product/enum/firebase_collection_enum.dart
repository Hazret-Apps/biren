import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  students,
  announcement,
  teachers,
  classes;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
