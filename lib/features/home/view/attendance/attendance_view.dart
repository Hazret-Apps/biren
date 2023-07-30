import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  final currentDate = DateTime.now();
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('dd MMMM', 'tr_TR').format(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: StreamBuilder(
        stream: FirebaseCollections.students.reference
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("attendance")
            .doc(
              DateTime.now().day.toString() +
                  DateTime.now().month.toString() +
                  DateTime.now().year.toString(),
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String text = "";
            switch (snapshot.data!["status"]) {
              case "came":
                text = "Geldi";
                break;
              case "didntCame":
                text = "Gelmedi";
                break;
              case "":
                text = "Boş";
                break;
              default:
            }
            return Center(
              child: Text(text),
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(formattedDate),
    );
  }
}
