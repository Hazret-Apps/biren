import 'package:biren_kocluk/features/admin/view/students/login_accept_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin LoginAcceptOperationMixin on State<LoginAcceptView> {
  late final String formattedDate;
  String? selectedGradeValue;
  TextEditingController studentPhone = TextEditingController();
  TextEditingController parentPhone = TextEditingController();

  final Stream<QuerySnapshot<Object?>> stream = FirebaseCollections
      .classes.reference
      .orderBy('name', descending: false)
      .snapshots();

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat(
      DateFormat.YEAR_MONTH_DAY,
      "tr_TR",
    ).format(widget.userModel.createdTime.toDate());
  }

  Future<void> onSubmitButton() async {
    if (selectedGradeValue != null) {
      FirebaseCollections.students.reference.doc(widget.userModel.uid).update({
        "isVerified": true,
        "class": selectedGradeValue,
        "grade": int.parse(selectedGradeValue!.characters.first),
        "studentPhone": studentPhone.text,
        "parentPhone": parentPhone.text,
      });
    }
  }
}
