import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AdminAllHomeworkCard extends StatefulWidget {
  const AdminAllHomeworkCard({
    super.key,
    required this.snapshot,
    required this.index,
  });
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<AdminAllHomeworkCard> createState() => _AdminAllHomeworkCardState();
}

class _AdminAllHomeworkCardState extends State<AdminAllHomeworkCard> {
  late DateTime dateTime;
  late String formattedDate;
  late QueryDocumentSnapshot<Object?> snapshot;

  late IconData icon;
  late Color color;
  late Color textColor;
  late String madeText;

  void loadComponents() {
    dateTime = widget
        .snapshot.data!.docs[widget.index][FirestoreFieldConstants.dateField]
        .toDate();
    switch (snapshot[FirestoreFieldConstants.makeEnumField]) {
      case "pushed":
        icon = Icons.alarm_rounded;
        color = LightThemeColors.blazeOrange;
        madeText = LocaleKeys.pushed.tr();
        textColor = LightThemeColors.white;
        break;
      case "missing":
        icon = Icons.remove_circle_outline;
        color = const Color.fromARGB(255, 254, 207, 15);
        madeText = LocaleKeys.missing.tr();
        textColor = LightThemeColors.white;

        break;
      case "made":
        icon = Icons.check_box_rounded;
        color = LightThemeColors.green;
        madeText = LocaleKeys.made.tr();
        textColor = LightThemeColors.white;

        break;
      case "didntMade":
        icon = Icons.close;
        color = LightThemeColors.red;
        madeText = LocaleKeys.didntMade.tr();
        textColor = LightThemeColors.white;

        break;
      case "empty":
        icon = Icons.hourglass_empty_rounded;
        color = LightThemeColors.white;
        madeText = LocaleKeys.notPushed.tr();

        textColor = LightThemeColors.black;

        break;
    }
  }

  @override
  void initState() {
    super.initState();
    snapshot = widget.snapshot.data!.docs[widget.index];
    loadComponents();
    formattedDate = DateFormat('dd/MM/yyyy').format(
      dateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Container(
        height: context.height / 4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: context.normalBorderRadius,
        ),
        child: Padding(
          padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _nameText(context),
                  const Spacer(),
                  _popupMenuButton(context)
                ],
              ),
              _subjectText(),
              context.emptySizedHeightBoxLow,
              snapshot[FirestoreFieldConstants.descriptionField] == ""
                  ? const SizedBox.shrink()
                  : _descriptionText(context),
              context.emptySizedHeightBoxLow,
              _dateText(context),
            ],
          ),
        ),
      ),
    );
  }

  Text _nameText(BuildContext context) {
    return Text(
      snapshot[FirestoreFieldConstants.assignedNameField],
      style: context.textTheme.titleLarge
          ?.copyWith(fontWeight: FontWeight.bold, color: textColor),
    );
  }

  Text _subjectText() {
    return Text(
      "${snapshot[FirestoreFieldConstants.subjectField]}: ${snapshot[FirestoreFieldConstants.topicField]}",
      overflow: TextOverflow.clip,
      style: TextStyle(color: textColor),
    );
  }

  Text _descriptionText(BuildContext context) {
    return Text(
      snapshot[FirestoreFieldConstants.descriptionField],
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      maxLines: 3,
    );
  }

  Text _dateText(BuildContext context) {
    return Text(
      formattedDate,
      style: context.textTheme.bodyMedium
          ?.copyWith(fontWeight: FontWeight.normal, color: textColor),
    );
  }

  PopupMenuButton<dynamic> _popupMenuButton(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(-10, 50),
      shape: RoundedRectangleBorder(
        borderRadius: context.normalBorderRadius,
      ),
      onSelected: (value) {
        if (value == 0) {
          if (mounted) {
            FirebaseCollections.homeworks.reference.doc(snapshot.id).update({
              FirestoreFieldConstants.makeEnumField: "made",
            });
            setState(() {
              color = LightThemeColors.green;
              textColor = LightThemeColors.white;
            });
          }
        } else if (value == 1) {
          if (mounted) {
            FirebaseCollections.homeworks.reference.doc(snapshot.id).update({
              FirestoreFieldConstants.makeEnumField: "didntMade",
            });
            setState(() {
              color = LightThemeColors.red;
              textColor = LightThemeColors.white;
            });
          }
        } else if (value == 2) {
          if (mounted) {
            FirebaseCollections.homeworks.reference.doc(snapshot.id).update({
              FirestoreFieldConstants.makeEnumField: "missing",
            });
            setState(() {
              color = LightThemeColors.lightYellow;
              textColor = LightThemeColors.white;
            });
          }
        }
      },
      itemBuilder: (ctx) => [
        _buildPopupMenuItem(
          "Yaptı",
          0,
          Icons.done_rounded,
          context,
        ),
        _buildPopupMenuItem(
          "Yapmadı",
          1,
          Icons.close_rounded,
          context,
        ),
        _buildPopupMenuItem(
          "Eksik",
          2,
          Icons.remove_circle_outline,
          context,
        ),
      ],
    );
  }

  PopupMenuItem _buildPopupMenuItem(
    String title,
    int value,
    IconData iconData,
    BuildContext context,
  ) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(iconData, color: LightThemeColors.black),
          context.emptySizedWidthBoxLow3x,
          Text(title),
        ],
      ),
    );
  }
}
