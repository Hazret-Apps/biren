import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StudentPushedHomeworkCard extends StatefulWidget {
  const StudentPushedHomeworkCard({
    super.key,
    required this.snapshot,
    required this.index,
  });

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<StudentPushedHomeworkCard> createState() =>
      _StudentPushedHomeworkCardState();
}

class _StudentPushedHomeworkCardState extends State<StudentPushedHomeworkCard> {
  late DateTime dateTime;
  late String formattedDate;

  IconData icon = Icons.alarm_rounded;
  Color color = LightThemeColors.blazeOrange;
  String madeText = LocaleKeys.pushed.tr();

  @override
  void initState() {
    super.initState();
    dateTime = widget.snapshot.data!.docs[widget.index]["date"].toDate();
    formattedDate = DateFormat('dd/MM/yyyy').format(
      dateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
      child: Container(
        height: context.height / 4.7,
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
              madeText == LocaleKeys.notPushed.tr()
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.snapshot.data!.docs[widget.index]
                                    ["senderName"],
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: color == LightThemeColors.white
                                      ? LightThemeColors.black
                                      : LightThemeColors.white,
                                ),
                              ),
                              context.emptySizedHeightBoxLow,
                              _subjectText(
                                widget.snapshot,
                                widget.index,
                                context,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        _madeText(context),
                        context.emptySizedWidthBoxLow,
                        _icon(),
                      ],
                    ),
                    _topicText(widget.snapshot, widget.index, context),
                    madeText == LocaleKeys.notPushed.tr()
                        ? const SizedBox.shrink()
                        : _dateText(widget.snapshot, widget.index, context),
                  ],
                ),
              ),
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
      "${LocaleKeys.pushed.tr()}: $formattedDate",
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
        fontSize: 16,
        color: color == LightThemeColors.white
            ? LightThemeColors.black
            : LightThemeColors.white,
      ),
      overflow: TextOverflow.ellipsis,
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
      overflow: TextOverflow.ellipsis,
    );
  }
}
