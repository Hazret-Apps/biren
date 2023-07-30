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
        stream: FirebaseCollections.students.reference
            .where(FirestoreFieldConstants.isVerifiedField, isEqualTo: true)
            .snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return ListView.builder(
              itemCount: userSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final QueryDocumentSnapshot<Object?> data =
                    userSnapshot.data!.docs[index];
                final UserModel userModel = UserModel(
                  name: data[FirestoreFieldConstants.nameField],
                  mail: data[FirestoreFieldConstants.mailField],
                  password: data[FirestoreFieldConstants.passwordField],
                  createdTime: data[FirestoreFieldConstants.createdTimeField],
                  isVerified: data[FirestoreFieldConstants.isVerifiedField],
                  uid: data[FirestoreFieldConstants.uidField],
                );
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseCollections.students.reference
                      .doc(data[FirestoreFieldConstants.uidField])
                      .collection("attendance")
                      .doc(
                        DateTime.now().day.toString() +
                            DateTime.now().month.toString() +
                            DateTime.now().year.toString(),
                      )
                      .snapshots(),
                  builder: (context, attendanceSnapshot) {
                    if (attendanceSnapshot.hasData) {
                      return _StudentWidget(
                        userModel,
                        attendanceSnapshot,
                      );
                    } else {
                      return const _LoadingWidget();
                    }
                  },
                );
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

class AttendanceModel {
  final String status;

  AttendanceModel(this.status);
}

class _StudentWidget extends StatefulWidget {
  const _StudentWidget(
    this.userModel,
    this.attendanceSnapshot,
  );
  final UserModel userModel;
  final AsyncSnapshot<DocumentSnapshot<Object?>> attendanceSnapshot;

  @override
  State<_StudentWidget> createState() => __StudentWidgetState();
}

class __StudentWidgetState extends State<_StudentWidget> {
  Color bgColor = LightThemeColors.scaffoldBackgroundColor;
  Color textColor = LightThemeColors.black;
  String status = "";
  int statusIndex = 0;

  Future<void> loadStatus() async {
    if (widget.attendanceSnapshot.data!.exists) {
      status = await widget.attendanceSnapshot.data?["status"];
    }
  }

  void loadComponents() async {
    await loadStatus();

    setState(() {
      switch (status) {
        case "came":
          bgColor = LightThemeColors.green;
          textColor = LightThemeColors.white;
          statusIndex = 1;
          break;
        case "didntCame":
          bgColor = LightThemeColors.red;
          textColor = LightThemeColors.white;
          statusIndex = 2;
          break;
        case "":
          bgColor = LightThemeColors.scaffoldBackgroundColor;
          textColor = LightThemeColors.black;
          statusIndex = 0;
          break;
        default:
      }
    });
  }

  void loadFirebase() {
    FirebaseCollections.students.reference
        .doc(widget.userModel.uid)
        .collection("attendance")
        .doc(
          DateTime.now().day.toString() +
              DateTime.now().month.toString() +
              DateTime.now().year.toString(),
        )
        .set({
      FirestoreFieldConstants.statusField: status,
      FirestoreFieldConstants.nameField: widget.userModel.name,
      FirestoreFieldConstants.dateField: Timestamp.now(),
      FirestoreFieldConstants.uidField: widget.userModel.uid,
    });
  }

  @override
  void initState() {
    super.initState();
    loadComponents();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (statusIndex == 0) {
            status = "came";
            bgColor = LightThemeColors.green;
            textColor = LightThemeColors.white;
            statusIndex = 1;
            loadFirebase();
          } else if (statusIndex == 1) {
            status = "didntCame";
            bgColor = LightThemeColors.red;
            textColor = LightThemeColors.white;
            statusIndex = 2;
            loadFirebase();
          } else if (statusIndex == 2) {
            status = "";
            bgColor = LightThemeColors.scaffoldBackgroundColor;
            textColor = LightThemeColors.black;
            statusIndex = 0;
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
