import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassDetailView extends StatefulWidget {
  const ClassDetailView(
      {super.key, required this.snapshot, required this.index});
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<ClassDetailView> createState() => _ClassDetailViewState();
}

class _ClassDetailViewState extends State<ClassDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: StreamBuilder(
        stream: FirebaseCollections.students.reference
            .where("class",
                isEqualTo: widget.snapshot.data!.docs[widget.index]["name"])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return _studentWidget(snapshot, index);
              },
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }

  ListTile _studentWidget(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          snapshot.data!.docs[index]["name"].toString().characters.first,
        ),
      ),
      title: Text(snapshot.data!.docs[index]["name"]),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(widget.snapshot.data!.docs[widget.index]["name"]),
    );
  }
}
