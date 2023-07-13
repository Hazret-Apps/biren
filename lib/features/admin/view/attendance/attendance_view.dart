import 'package:biren_kocluk/features/admin/view/attendance/mixin/admin_attendance_operation_mixin.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AdminAttendanceView extends StatefulWidget {
  const AdminAttendanceView({super.key});

  @override
  State<AdminAttendanceView> createState() => _AdminAttendanceViewState();
}

class _AdminAttendanceViewState extends State<AdminAttendanceView>
    with AdminAttendanceOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                UserModel userModel = UserModel(
                  name: snapshot.data!.docs[index]
                      [FirestoreFieldConstants.nameField],
                  mail: snapshot.data!.docs[index]
                      [FirestoreFieldConstants.mailField],
                  password: snapshot.data!.docs[index]
                      [FirestoreFieldConstants.passwordField],
                  createdTime: snapshot.data!.docs[index]
                      [FirestoreFieldConstants.createdTimeField],
                  isVerified: snapshot.data!.docs[index]
                      [FirestoreFieldConstants.isVerifiedField],
                  uid: snapshot.data!.docs[index]
                      [FirestoreFieldConstants.uidField],
                );
                return _StudentWidget(userModel);
              },
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
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

class _StudentWidget extends StatefulWidget {
  const _StudentWidget(this.userModel);
  final UserModel userModel;

  @override
  State<_StudentWidget> createState() => __StudentWidgetState();
}

class __StudentWidgetState extends State<_StudentWidget> {
  int statusIndex = 0;
  String status = "";
  Color bgColor = LightThemeColors.scaffoldBackgroundColor;
  Color textColor = LightThemeColors.black;

  void _loadFirestore() {
    FirebaseCollections.attendance.reference
        .doc(DateTime.now().year.toString() +
            DateTime.now().month.toString() +
            DateTime.now().day.toString() +
            widget.userModel.uid)
        .set({
      FirestoreFieldConstants.statusField: status,
      FirestoreFieldConstants.studentField: widget.userModel.uid,
      FirestoreFieldConstants.studentNameField: widget.userModel.name,
      FirestoreFieldConstants.dateField: Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (statusIndex == 0) {
            bgColor = LightThemeColors.green;
            statusIndex = 1;
            status = "came";
            textColor = LightThemeColors.white;
            _loadFirestore();
          } else if (statusIndex == 1) {
            bgColor = LightThemeColors.red;
            statusIndex = 2;
            status = "didntCame";
            textColor = LightThemeColors.white;
            _loadFirestore();
          } else if (statusIndex == 2) {
            bgColor = LightThemeColors.scaffoldBackgroundColor;
            statusIndex = 0;
            status = "empty";
            textColor = LightThemeColors.black;
            _loadFirestore();
          }
        });
      },
      child: Padding(
        padding: context.horizontalPaddingLow + context.verticalPaddingLow,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: context.normalBorderRadius,
            color: bgColor,
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(widget.userModel.name.characters.first),
            ),
            title: Text(
              widget.userModel.name,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
