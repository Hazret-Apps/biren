import 'package:biren_kocluk/features/admin/view/students/student_edit_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin StudentEditOperationMixin on State<StudentEditView> {
  final Stream<QuerySnapshot> stream = FirebaseCollections.classes.reference
      .orderBy('name', descending: false)
      .snapshots();

  late final String formattedDate;
  String? selectedGradeValue;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat(
      DateFormat.YEAR_MONTH_DAY,
      "tr_TR",
    ).format(widget.userModel.createdTime.toDate());
  }

  void onSubmitButton() {
    if (selectedGradeValue != null) {
      FirebaseCollections.students.reference.doc(widget.userModel.uid).update({
        FirestoreFieldConstants.classField: selectedGradeValue,
        FirestoreFieldConstants.gradeField:
            int.parse(selectedGradeValue!.characters.first),
      });
      Navigator.pop(context);
    }
  }
}
