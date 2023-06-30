import 'package:biren_kocluk/features/home/view/homeworks/check_homework_view.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/homework_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
    super.initState();
    dateTime = widget.snapshot.data!.docs[widget.index]["date"].toDate();
    formattedDate = DateFormat('dd/MM/yyyy').format(
      dateTime,
    );
    widget.snapshot.data!.docs[widget.index]["type"] == "class"
        ? isClass = true
        : isClass = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
      child: Container(
        height: context.height / 5,
        decoration: BoxDecoration(
            color: LightThemeColors.white,
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
              Row(
                children: [
                  _subjectText(widget.snapshot, widget.index, context),
                  const Spacer(),
                  PopupMenuButton(
                    offset: const Offset(-10, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: context.normalBorderRadius,
                    ),
                    onSelected: (value) {
                      if (value == 0) {
                      } else if (value == 1) {
                        _checkDialog(context, widget.snapshot, widget.index);
                      } else if (value == 2) {}
                    },
                    itemBuilder: (ctx) => [
                      _buildPopupMenuItem(
                        "Soru Sor",
                        0,
                        Icons.info_outline_rounded,
                        context,
                      ),
                      widget.snapshot.data!.docs[widget.index]["makeEnum"] ==
                              "pushed"
                          ? _buildPopupMenuItem(
                              "Gönderildi",
                              2,
                              Icons.arrow_circle_right_outlined,
                              context,
                            )
                          : _buildPopupMenuItem(
                              "Tamamlandı",
                              1,
                              Icons.check_rounded,
                              context,
                            ),
                    ],
                  )
                ],
              ),
              _topicText(widget.snapshot, widget.index, context),
              context.emptySizedHeightBoxLow,
              Text(
                formattedDate,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: LightThemeColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkDialog(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text("Fotoğraf Çek"),
          content: const Text(
            "Öğretmenlerinin ödevinden emin olabilmesi "
            "için ödevinin fotoğrafını çek",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CheckHomeworkView(
                      homework: Homework(
                        date: snapshot.data!.docs[index]["date"].toDate(),
                        lesson: snapshot.data!.docs[index]["subject"],
                        topic: snapshot.data!.docs[index]["topic"],
                        user: snapshot.data!.docs[index]["user"],
                        makeEnum: snapshot.data!.docs[index]["makeEnum"],
                        id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  ),
                );
              },
              child: const Text(
                "Anladım",
                style: TextStyle(
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
      snapshot.data!.docs[index]["subject"],
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: LightThemeColors.black,
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
        color: LightThemeColors.black,
      ),
    );
  }
}
