import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceProvider extends ChangeNotifier {
  String status;
  Color color;
  Color textColor;

  AttendanceProvider({
    this.status = "empty",
    this.color = LightThemeColors.scaffoldBackgroundColor,
    this.textColor = LightThemeColors.black,
  });

  void changeColor() {}

  void changeStatus(
    String newStatus,
    Color newColor,
    Color newTextColor,
    UserModel userModel,
  ) {
    status = newStatus;
    color = newColor;
    textColor = newColor;
    FirebaseCollections.attendance.reference
        .doc(DateTime.now().year.toString() +
            DateTime.now().month.toString() +
            DateTime.now().day.toString() +
            userModel.uid)
        .set({
      FirestoreFieldConstants.statusField: status,
      FirestoreFieldConstants.studentField: userModel.uid,
      FirestoreFieldConstants.studentNameField: userModel.name,
      FirestoreFieldConstants.dateField: Timestamp.now(),
    });
    notifyListeners();
  }
}
