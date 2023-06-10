import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class PushedHomeworkCardLarge extends StatefulWidget {
  const PushedHomeworkCardLarge({
    super.key,
    required this.snapshot,
    required this.index,
  });

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<PushedHomeworkCardLarge> createState() =>
      _PushedHomeworkCardLargeState();
}

class _PushedHomeworkCardLargeState extends State<PushedHomeworkCardLarge> {
  late DateTime dateTime;
  late String formattedDate;

  late IconData icon;
  late Color color;
  late String madeText;

  void loadComponents() {
    switch (widget.snapshot.data!.docs[widget.index]["makeEnum"]) {
      case "pushed":
        icon = Icons.alarm_rounded;
        color = LightThemeColors.blazeOrange;
        madeText = "Gönderildi";
        break;
      case "missing":
        icon = Icons.remove_circle_outline;
        color = const Color.fromARGB(255, 254, 207, 15);
        madeText = "Eksik";
        break;
      case "made":
        icon = Icons.check_box_rounded;
        color = LightThemeColors.green;
        madeText = "Yapıldı";
        break;
      case "didntMade":
        icon = Icons.close;
        color = LightThemeColors.red;
        madeText = "Yapılmadı";
        break;
      case "waiting":
        icon = Icons.hourglass_empty_rounded;
        color = LightThemeColors.white;
        madeText = "Gönderilmedi";
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    dateTime = widget.snapshot.data!.docs[widget.index]["date"].toDate();
    formattedDate = DateFormat('dd/MM/yyyy').format(
      dateTime,
    );
    loadComponents();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
      child: Container(
        height: context.height / 5,
        decoration: BoxDecoration(
            color: color,
            borderRadius: context.normalBorderRadius,
            boxShadow: [
              BoxShadow(
                color: LightThemeColors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(
                  5,
                  15,
                ),
              ),
            ]),
        child: Padding(
          padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.emptySizedHeightBoxLow,
              Row(
                children: [
                  _subjectText(widget.snapshot, widget.index, context),
                  const Spacer(),
                  Text(
                    madeText,
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: LightThemeColors.white),
                  ),
                  context.emptySizedWidthBoxLow,
                  Icon(
                    icon,
                    color: LightThemeColors.white,
                  ),
                ],
              ),
              context.emptySizedHeightBoxLow,
              _topicText(widget.snapshot, widget.index, context),
              context.emptySizedHeightBoxLow,
              _dateText(widget.snapshot, widget.index, context),
            ],
          ),
        ),
      ),
    );
  }

  Text _dateText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      "Gönderilme Zamanı: $formattedDate",
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: LightThemeColors.white,
      ),
    );
  }

  Text _topicText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      snapshot.data!.docs[index]["topic"],
      style: context.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: LightThemeColors.white,
      ),
    );
  }

  Text _subjectText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      snapshot.data!.docs[index]["subject"],
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: LightThemeColors.white,
      ),
    );
  }
}
