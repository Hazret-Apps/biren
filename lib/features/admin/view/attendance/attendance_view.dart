import 'dart:developer';

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
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseCollections.attendance.reference
                  .where(
                    "date",
                    isEqualTo: DateTime.now().day.toString() +
                        DateTime.now().month.toString() +
                        DateTime.now().year.toString(),
                  )
                  .snapshots(),
              builder: (context, attendanceSnapshot) {
                if (attendanceSnapshot.hasData) {
                  if (attendanceSnapshot.data!.docs.isNotNullOrEmpty) {
                    return ListView.builder(
                      itemCount: userSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final userSnapshotRef = userSnapshot.data!.docs[index];
                        UserModel userModel = UserModel(
                          name: userSnapshotRef[
                              FirestoreFieldConstants.nameField],
                          mail: userSnapshotRef[
                              FirestoreFieldConstants.mailField],
                          password: userSnapshotRef[
                              FirestoreFieldConstants.passwordField],
                          createdTime: userSnapshotRef[
                              FirestoreFieldConstants.createdTimeField],
                          isVerified: userSnapshotRef[
                              FirestoreFieldConstants.isVerifiedField],
                          uid:
                              userSnapshotRef[FirestoreFieldConstants.uidField],
                        );

                        return _StudentWidget(
                          userModel,
                          attendanceSnapshot.data!.docs,
                          index,
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: userSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final userSnapshotRef = userSnapshot.data!.docs[index];
                        UserModel userModel = UserModel(
                          name: userSnapshotRef[
                              FirestoreFieldConstants.nameField],
                          mail: userSnapshotRef[
                              FirestoreFieldConstants.mailField],
                          password: userSnapshotRef[
                              FirestoreFieldConstants.passwordField],
                          createdTime: userSnapshotRef[
                              FirestoreFieldConstants.createdTimeField],
                          isVerified: userSnapshotRef[
                              FirestoreFieldConstants.isVerifiedField],
                          uid:
                              userSnapshotRef[FirestoreFieldConstants.uidField],
                        );

                        return _StudentWidget(userModel, null, index);
                      },
                    );
                  }
                } else {
                  return const _LoadingWidget();
                }
              },
            );
          } else {
            return const _LoadingWidget();
          }
        },
      ),
    );
  }

  AppBar _appBar() => AppBar(title: Text(formattedDate));
}

class _StudentWidget extends StatefulWidget {
  const _StudentWidget(this.userModel, this.attendanceDocs, this.index);
  final UserModel userModel;
  final List<QueryDocumentSnapshot<Object?>>? attendanceDocs;
  final int index;

  @override
  State<_StudentWidget> createState() => __StudentWidgetState();
}

class __StudentWidgetState extends State<_StudentWidget> {
  int statusIndex = 0;
  Color bgColor = LightThemeColors.scaffoldBackgroundColor;
  Color textColor = LightThemeColors.black;
  String status = "";

  @override
  void initState() {
    super.initState();
    initComponents();
  }

  void loadFirebase() {
    FirebaseCollections.attendance.reference
        .doc(DateTime.now().year.toString() +
            DateTime.now().month.toString() +
            DateTime.now().day.toString() +
            widget.userModel.uid)
        .set({
      FirestoreFieldConstants.statusField: status,
      FirestoreFieldConstants.studentField: widget.userModel.uid,
      FirestoreFieldConstants.studentNameField: widget.userModel.name,
      FirestoreFieldConstants.dateField: DateTime.now().day.toString() +
          DateTime.now().month.toString() +
          DateTime.now().year.toString()
    });
  }

  void initComponents() async {
    if ((await widget.attendanceDocs?[widget.index]["status"] ?? false) ==
        null) {
      status = "";
    } else {
      status = await widget.attendanceDocs?[widget.index]["status"] ?? "";
    }

    setState(() {
      if (status != "") {
        if (status == "came") {
          status = "came";
          statusIndex = 1;
          textColor = LightThemeColors.white;
          bgColor = LightThemeColors.green;
        } else if (status == "didntCame") {
          status = "didntCame";
          statusIndex = 0;
          textColor = LightThemeColors.white;
          bgColor = LightThemeColors.red;
        }
      } else {
        status = "";
        statusIndex = 0;
        textColor = LightThemeColors.black;
        bgColor = LightThemeColors.scaffoldBackgroundColor;
      }
    });
    log(widget.index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (statusIndex == 0) {
            statusIndex = 1;
            status = "came";
            bgColor = LightThemeColors.green;
            textColor = LightThemeColors.white;
            loadFirebase();
          } else if (statusIndex == 1) {
            statusIndex = 0;
            status = "didntCame";
            bgColor = LightThemeColors.red;
            textColor = LightThemeColors.white;
            loadFirebase();
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
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
