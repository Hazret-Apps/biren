import 'package:biren_kocluk/features/home/view/exams/exam_detail_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ExamWidget extends StatelessWidget {
  const ExamWidget(this.snapshot, this.index, {super.key});
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.verticalPaddingLow,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
                  ExamDetailView(snapshot: snapshot, index: index),
            ),
          );
        },
        child: SizedBox(
          height: context.height / 6,
          child: Card(
            child: Padding(
              padding: context.paddingNormal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _chartIcon(),
                      context.emptySizedWidthBoxLow3x,
                      Expanded(child: _titleText(context)),
                    ],
                  ),
                  context.emptySizedHeightBoxLow,
                  _descriptionText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Icon _chartIcon() {
    return const Icon(
      Icons.bar_chart_rounded,
      size: 30,
    );
  }

  Text _titleText(BuildContext context) {
    return Text(
      snapshot.data?.docs[index][FirestoreFieldConstants.titleField] == ""
          ? LocaleKeys.noTitle.tr()
          : snapshot.data?.docs[index][FirestoreFieldConstants.titleField],
      overflow: TextOverflow.ellipsis,
    );
  }

  Text _descriptionText(BuildContext context) {
    return Text(
      snapshot.data?.docs[index][FirestoreFieldConstants.descriptionField] == ""
          ? LocaleKeys.noDescription.tr()
          : snapshot.data?.docs[index]
              [FirestoreFieldConstants.descriptionField],
      style: context.textTheme.labelMedium,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
