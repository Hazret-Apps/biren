import 'package:biren_kocluk/features/home/view/homeworks/check_homework_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/homework_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeworkCardLarge extends StatefulWidget {
  const HomeworkCardLarge({
    super.key,
    required this.snapshot,
    required this.index,
  });

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<HomeworkCardLarge> createState() => _HomeworkCardLargeState();
}

class _HomeworkCardLargeState extends State<HomeworkCardLarge> {
  late DateTime dateTime;
  late String formattedDate;
  late bool isClass;

  late QueryDocumentSnapshot<Object?> snapshot;

  @override
  void initState() {
    super.initState();
    snapshot = widget.snapshot.data!.docs[widget.index];
    dateTime = snapshot[FirestoreFieldConstants.dateField].toDate();
    formattedDate = DateFormat('dd/MM/yyyy').format(
      dateTime,
    );
    snapshot[FirestoreFieldConstants.typeField] ==
            FirestoreFieldConstants.classField
        ? isClass = true
        : isClass = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Container(
        height: context.height / 4,
        decoration: BoxDecoration(
          color: LightThemeColors.white,
          borderRadius: context.normalBorderRadius,
        ),
        child: Padding(
          padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _subjectText(widget.snapshot, widget.index, context),
                  const Spacer(),
                  _popupMenuButton(context)
                ],
              ),
              _topicText(widget.snapshot, widget.index, context),
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

  Text _descriptionText(BuildContext context) {
    return Text(
      snapshot[FirestoreFieldConstants.descriptionField],
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.normal,
      ),
      maxLines: 3,
    );
  }

  Text _dateText(BuildContext context) {
    return Text(
      formattedDate,
      style: context.textTheme.bodyLarge?.copyWith(
        color: LightThemeColors.black,
      ),
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
        } else if (value == 1) {
          _checkDialog(context, widget.snapshot, widget.index);
        } else if (value == 2) {
        } else if (value == 3) {}
      },
      itemBuilder: (ctx) => [
        _buildPopupMenuItem(
          LocaleKeys.askQuestion.tr(),
          0,
          Icons.info_outline_rounded,
          context,
        ),
        widget.snapshot.data!.docs[widget.index]
                    [FirestoreFieldConstants.makeEnumField] ==
                "pushed"
            ? _buildPopupMenuItem(
                LocaleKeys.pushed.tr(),
                2,
                Icons.arrow_circle_right_outlined,
                context,
              )
            : widget.snapshot.data!.docs[widget.index]
                        [FirestoreFieldConstants.typeField] ==
                    FirestoreFieldConstants.studentField
                ? _buildPopupMenuItem(
                    LocaleKeys.complated.tr(),
                    1,
                    Icons.check_rounded,
                    context,
                  )
                : _buildPopupMenuItem(
                    "Sınıf Ödevleri Gönderilemez",
                    3,
                    Icons.group_outlined,
                    context,
                  )
      ],
    );
  }

  Future<void> _checkDialog(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(LocaleKeys.takePhoto.tr()),
          content: Text(LocaleKeys.submitHomeworkDescriptionDialog.tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CheckHomeworkView(
                      homework: Homework(
                        date: snapshot.data!
                            .docs[index][FirestoreFieldConstants.dateField]
                            .toDate(),
                        lesson: snapshot.data!.docs[index]
                            [FirestoreFieldConstants.subjectField],
                        topic: snapshot.data!.docs[index]
                            [FirestoreFieldConstants.topicField],
                        user: snapshot.data!.docs[index]
                            [FirestoreFieldConstants.assignedIdField],
                        makeEnum: snapshot.data!.docs[index]
                            [FirestoreFieldConstants.makeEnumField],
                        id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                LocaleKeys.understand.tr(),
                style: const TextStyle(
                  color: LightThemeColors.blazeOrange,
                ),
              ),
            )
          ],
        );
      },
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

  Text _subjectText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      snapshot.data!.docs[index][FirestoreFieldConstants.subjectField],
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: LightThemeColors.black,
      ),
    );
  }

  Text _topicText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      snapshot.data!.docs[index][FirestoreFieldConstants.topicField],
      style: context.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: LightThemeColors.black,
      ),
    );
  }
}
