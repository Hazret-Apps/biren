import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class AllHomeworkCardLarg extends StatefulWidget {
  const AllHomeworkCardLarg({
    super.key,
    required this.snapshot,
    required this.index,
  });

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<AllHomeworkCardLarg> createState() => _HomeworkCardLargeState();
}

class _HomeworkCardLargeState extends State<AllHomeworkCardLarg> {
  late DateTime dateTime;
  late String formattedDate;

  late Color color;
  late Color textColor;

  void loadComponents() {
    switch (widget.snapshot.data!.docs[widget.index]["makeEnum"]) {
      case "pushed":
        color = LightThemeColors.blazeOrange;
        textColor = LightThemeColors.white;
        break;
      case "missing":
        color = const Color.fromARGB(255, 254, 207, 15);
        textColor = LightThemeColors.white;
        break;
      case "made":
        color = LightThemeColors.green;
        textColor = LightThemeColors.white;
        break;
      case "didntMade":
        color = LightThemeColors.red;
        textColor = LightThemeColors.white;
        break;
      case "empty":
        color = LightThemeColors.white;
        textColor = LightThemeColors.black;

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
          ],
        ),
        child: Padding(
          padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              color == LightThemeColors.white
                  ? const SizedBox.shrink()
                  : Container(
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
                  context.emptySizedHeightBoxLow,
                  _nameText(context),
                  context.emptySizedHeightBoxLow,
                  SizedBox(
                    width: context.width / 1.83,
                    child: _topicText(
                      widget.snapshot,
                      widget.index,
                      context,
                    ),
                  ),
                  context.emptySizedHeightBoxLow,
                  _dateText(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _nameText(BuildContext context) {
    return Text(
      widget.snapshot.data!.docs[widget.index]["assignedName"],
      style: context.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: textColor,
      ),
    );
  }

  Text _dateText(BuildContext context) {
    return Text(
      formattedDate,
      style: context.textTheme.bodyLarge?.copyWith(
        color: textColor,
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
        color: textColor,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
