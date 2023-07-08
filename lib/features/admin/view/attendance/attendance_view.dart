import 'package:biren_kocluk/features/admin/view/attendance/attendance_history.dart';
import 'package:biren_kocluk/features/admin/view/attendance/mixin/admin_attendance_operation_mixin.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
      body: SafeArea(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length + 1,
                  itemBuilder: (context, index) {
                    if (index < snapshot.data!.docs.length) {
                      return _StudentWidget(snapshot, index);
                    }
                    return Padding(
                      padding: context.horizontalPaddingNormal +
                          context.verticalPaddingNormal,
                      child: MainButton(
                        onPressed: () {
                          FirebaseCollections.attendance.reference.add({});
                        },
                        text: "Kaydet",
                      ),
                    );
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

  AppBar _appBar() {
    return AppBar(
      title: Text(formattedDate),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AttendanceHistoryView(),
              ),
            );
          },
          child: const Icon(Icons.history_rounded),
        ),
        context.emptySizedWidthBoxNormal,
      ],
    );
  }
}

class _StudentWidget extends StatefulWidget {
  const _StudentWidget(this.snapshot, this.index);

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<_StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<_StudentWidget> {
  int index = 0;
  Color color = Colors.transparent;
  String text = "";
  Color textColor = LightThemeColors.black;

  void changeCame() {
    setState(() {
      index++;
      color = LightThemeColors.green;
      text = "Geldi";
      textColor = LightThemeColors.white;
    });
  }

  void changeDindtCame() {
    setState(() {
      index++;
      color = LightThemeColors.red;
      text = "Gelmedi";
      textColor = LightThemeColors.white;
    });
  }

  void changeNull() {
    setState(() {
      index = 0;
      color = Colors.transparent;
      text = "";
      textColor = LightThemeColors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          changeCame();
        } else if (index == 1) {
          changeDindtCame();
        } else if (index == 2) {
          changeNull();
        }
      },
      child: Padding(
        padding: context.verticalPaddingLow + context.horizontalPaddingLow,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: context.normalBorderRadius,
            color: color,
          ),
          child: Padding(
            padding: context.paddingLow,
            child: Row(
              children: [
                _avatar(),
                context.emptySizedWidthBoxLow3x,
                _studentName(context),
                const Spacer(),
                Text(text, style: TextStyle(color: textColor)),
                context.emptySizedWidthBoxLow3x,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _studentName(BuildContext context) {
    return Text(
      widget.snapshot.data!.docs[widget.index]["name"],
      style: context.textTheme.bodyLarge?.copyWith(
        color: textColor,
      ),
    );
  }

  CircleAvatar _avatar() {
    return CircleAvatar(
      child: Text(
        widget.snapshot.data!.docs[widget.index]["name"]
            .toString()
            .characters
            .first,
      ),
    );
  }
}
