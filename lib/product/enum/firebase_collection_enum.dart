import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  users,
  announcement,
  homeworks;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
