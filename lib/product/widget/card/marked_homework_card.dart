import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MarkedHomeworkCard extends StatefulWidget {
  const MarkedHomeworkCard({
    super.key,
    required this.snapshot,
    required this.index,
  });
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<MarkedHomeworkCard> createState() => _MarkedHomeworkCardState();
}

class _MarkedHomeworkCardState extends State<MarkedHomeworkCard> {
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
          padding:
              context.horizontalPaddingNormal + context.verticalPaddingNormal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _nameText(context),
              context.emptySizedHeightBoxLow,
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
}
