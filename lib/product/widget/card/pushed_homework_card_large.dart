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
      case "empty":
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
          padding:
              context.horizontalPaddingNormal + context.verticalPaddingNormal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              madeText == "Gönderilmedi"
                  ? const SizedBox.shrink()
                  : _imageContainer(context),
              color == LightThemeColors.white
                  ? const SizedBox.shrink()
                  : context.emptySizedWidthBoxLow3x,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _subjectText(widget.snapshot, widget.index, context),
                        const Spacer(),
                        _madeText(context),
                        context.emptySizedWidthBoxLow,
                        _icon(),
                      ],
                    ),
                    context.emptySizedHeightBoxLow,
                    _topicText(widget.snapshot, widget.index, context),
                    madeText == "Gönderilmedi"
                        ? const SizedBox.shrink()
                        : _dateText(widget.snapshot, widget.index, context),
                  ],
                ),
              ),
              // _subjectText(widget.snapshot, widget.index, context),
              // const Spacer(),
              // _madeText(context),
              // context.emptySizedWidthBoxLow,
              // _icon(),
            ],
          ),
        ),
      ),
    );
  }

  Icon _icon() {
    return Icon(
      icon,
      color: color == LightThemeColors.white
          ? LightThemeColors.black
          : LightThemeColors.white,
    );
  }

  Text _madeText(BuildContext context) {
    return Text(
      madeText,
      style: context.textTheme.bodyLarge?.copyWith(
        color: color == LightThemeColors.white
            ? LightThemeColors.black
            : LightThemeColors.white,
      ),
    );
  }

  Center _imageContainer(BuildContext context) {
    return Center(
      child: Container(
        height: context.height / 6,
        width: context.width / 4,
        decoration: BoxDecoration(
          borderRadius: context.normalBorderRadius,
          image: DecorationImage(
            image: NetworkImage(
              widget.snapshot.data!.docs[widget.index]["image"],
            ),
            fit: BoxFit.cover,
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
        overflow: TextOverflow.ellipsis,
        color: color == LightThemeColors.white
            ? LightThemeColors.black
            : LightThemeColors.white,
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
        color: color == LightThemeColors.white
            ? LightThemeColors.black
            : LightThemeColors.white,
      ),
    );
  }

  Text _subjectText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      snapshot.data!.docs[index]["subject"],
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: color == LightThemeColors.white
            ? LightThemeColors.black
            : LightThemeColors.white,
      ),
    );
  }
}
