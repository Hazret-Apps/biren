import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassDetailView extends StatelessWidget {
  const ClassDetailView({super.key, required this.snapshot});
  final QueryDocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(snapshot["name"]),
    );
  }
}
