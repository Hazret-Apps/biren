import 'package:cloud_firestore/cloud_firestore.dart';

class Homework {
  final String title;
  final String? description;
  final DateTime date;
  final String id;
  Homework({
    required this.title,
    this.description,
    required this.date,
    required this.id,
  });

  factory Homework.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Homework(
      date: data['date'].toDate(),
      title: data['title'],
      description: data['description'],
      id: snapshot.id,
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "title": title,
      "description": description
    };
  }
}
