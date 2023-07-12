import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ComingHomeworkCardLarge extends StatefulWidget {
  const ComingHomeworkCardLarge({
    super.key,
    required this.snapshot,
    required this.index,
  });

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<ComingHomeworkCardLarge> createState() => _HomeworkCardLargeState();
}

class _HomeworkCardLargeState extends State<ComingHomeworkCardLarge> {
  late DateTime dateTime;
  late String formattedDate;

  late Color color;

  void loadComponents() {
    switch (widget.snapshot.data!.docs[widget.index]["makeEnum"]) {
      case "pushed":
        color = LightThemeColors.blazeOrange;
        break;
      case "missing":
        color = const Color.fromARGB(255, 254, 207, 15);
        break;
      case "made":
        color = LightThemeColors.green;
        break;
      case "didntMade":
        color = LightThemeColors.red;
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    dateTime = widget.snapshot.data!.docs[widget.index]["pushedTime"].toDate();
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
          ],
        ),
        child: Padding(
          padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
          child: Row(
            children: [
              Container(
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
              context.emptySizedWidthBoxLow3x,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.width / 1.81,
                    child: Row(
                      children: [
                        _senderStudentText(
                          widget.snapshot,
                          widget.index,
                          context,
                        ),
                        const Spacer(),
                        PopupMenuButton(
                          offset: const Offset(-10, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: context.normalBorderRadius,
                          ),
                          onSelected: (value) {
                            if (value == 0) {
                              if (mounted) {
                                FirebaseCollections.homeworkPush.reference
                                    .doc(widget
                                        .snapshot.data!.docs[widget.index].id)
                                    .update({
                                  "makeEnum": "made",
                                });
                                FirebaseCollections.homeworks.reference
                                    .doc(widget.snapshot.data!
                                        .docs[widget.index]["homeworkId"])
                                    .update({
                                  "makeEnum": "made",
                                });
                                setState(() {
                                  color = LightThemeColors.green;
                                });
                              }
                            } else if (value == 1) {
                              if (mounted) {
                                FirebaseCollections.homeworkPush.reference
                                    .doc(widget
                                        .snapshot.data!.docs[widget.index].id)
                                    .update({
                                  "makeEnum": "didntMade",
                                });
                                FirebaseCollections.homeworks.reference
                                    .doc(widget.snapshot.data!
                                        .docs[widget.index]["homeworkId"])
                                    .update({
                                  "makeEnum": "didntMade",
                                });
                                setState(() {
                                  color = LightThemeColors.red;
                                });
                              }
                            } else if (value == 2) {
                              if (mounted) {
                                FirebaseCollections.homeworkPush.reference
                                    .doc(widget
                                        .snapshot.data!.docs[widget.index].id)
                                    .update({
                                  "makeEnum": "missing",
                                });
                                FirebaseCollections.homeworks.reference
                                    .doc(widget.snapshot.data!
                                        .docs[widget.index]["homeworkId"])
                                    .update({
                                  "makeEnum": "missing",
                                });
                                setState(() {
                                  color =
                                      const Color.fromARGB(255, 254, 207, 15);
                                });
                              }
                            }
                          },
                          itemBuilder: (ctx) => [
                            _buildPopupMenuItem(
                              LocaleKeys.made.tr(),
                              0,
                              Icons.check_box_outlined,
                              context,
                            ),
                            _buildPopupMenuItem(
                              LocaleKeys.didntMade.tr(),
                              1,
                              Icons.close,
                              context,
                            ),
                            _buildPopupMenuItem(
                              LocaleKeys.missing.tr(),
                              2,
                              Icons.remove_circle_outline,
                              context,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: context.width / 1.83,
                    child: _topicText(
                      widget.snapshot,
                      widget.index,
                      context,
                    ),
                  ),
                  context.emptySizedHeightBoxLow,
                  Text(
                    "Gönderilme Zamanı:\n$formattedDate",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: LightThemeColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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

  Text _topicText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      snapshot.data!.docs[index]["topic"],
      style: context.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: LightThemeColors.white,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Text _senderStudentText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      int index, BuildContext context) {
    return Text(
      snapshot.data!.docs[index]["senderName"],
      style: context.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: LightThemeColors.white,
      ),
    );
  }
}
