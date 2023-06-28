import 'package:biren_kocluk/features/admin/view/attendance/take_attendance_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

mixin TakeAttendanceOperationMixin on State<TakeAttendanceView> {
  late DateTime selectedDate;
  List<String> statusList = <String>["Geldi", "Gelmedi"];
  String? statusValueTR;
  String? statusValue;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate ?? DateTime.now();
  }

  void onSubmitButton() async {
    await FirebaseCollections.attendance.reference.add({
      "name": widget.snapshot.data!.docs[widget.index]["name"],
      "uid": widget.snapshot.data!.docs[widget.index]["uid"],
      "status": statusValue,
      "date": Timestamp.fromDate(selectedDate),
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
