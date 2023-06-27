import 'package:biren_kocluk/features/admin/view/attendance/enter_attendance_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminAttendanceView extends StatefulWidget {
  const AdminAttendanceView({super.key});

  @override
  State<AdminAttendanceView> createState() => _AdminAttendanceViewState();
}

class _AdminAttendanceViewState extends State<AdminAttendanceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseCollections.students.reference
                .where("isVerified", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return _StudentWidget(snapshot, index);
                  },
                );
              }
              return const Center(child: CircularProgressIndicator.adaptive());
            },
          ),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(title: const Text("Yoklama"));
}

class _StudentWidget extends StatelessWidget {
  const _StudentWidget(this.snapshot, this.index);

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _avatar(),
      title: Text(snapshot.data!.docs[index]["name"]),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EnterAttendanceView(
              name: snapshot.data!.docs[index]["name"],
              uid: snapshot.data!.docs[index]["uid"],
              // snapshot: snapshot,
              // index: index,
            ),
          ),
        );
      },
    );
  }

  CircleAvatar _avatar() {
    return CircleAvatar(
      child: Text(
        snapshot.data!.docs[index]["name"].toString().characters.first,
      ),
    );
  }
}
