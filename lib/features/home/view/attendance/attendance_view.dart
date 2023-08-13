import 'package:biren_kocluk/features/home/view/attendance/didnt_came_days_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/card/admin_features_select_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

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
      body: StreamBuilder<DocumentSnapshot>(
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

            Map<String, dynamic>? dataMap =
                snapshot.data?.data() as Map<String, dynamic>?;

            if (dataMap != null && dataMap["status"] != null) {
              switch (dataMap["status"]) {
                case "came":
                  text = "Geldi";
                  break;
                case "didntCame":
                  text = "Gelmedi";
                  break;
                default:
                  text = "Bilinmeyen durum";
                  break;
              }
            } else {
              text = "Yoklama alınmadı.";
            }

            return ListView(
              children: [
                Padding(
                  padding: context.horizontalPaddingNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$formattedDate:",
                        style: context.textTheme.displayMedium,
                      ),
                      context.emptySizedHeightBoxLow,
                      Text(
                        text,
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                context.emptySizedHeightBoxLow,
                Padding(
                  padding: context.horizontalPaddingLow,
                  child: const SelectFeatureListTile(
                    title: "Gelinmeyen Günler",
                    subtitle: "Öğrencinin  Okula Gelmediği Günler.",
                    icon: Icons.close_rounded,
                    callView: DidntCameDaysView(),
                    color: LightThemeColors.red,
                  ),
                ),
              ],
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
      title: Text(LocaleKeys.features_attendance.tr()),
    );
  }
}
