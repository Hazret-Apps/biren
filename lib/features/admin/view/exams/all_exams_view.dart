import 'package:biren_kocluk/features/home/view/exams/widget/exam_widget.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AllExamsView extends StatefulWidget {
  const AllExamsView({super.key});

  @override
  State<AllExamsView> createState() => _AllExamsViewState();
}

class _AllExamsViewState extends State<AllExamsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const _Body(),
    );
  }

  AppBar _appBar() => AppBar(title: const Text("Tüm Sınavlar"));
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollections.exams.reference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: context.horizontalPaddingNormal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ExamWidget(snapshot, index);
              },
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
