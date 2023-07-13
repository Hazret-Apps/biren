import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.formattedDate,
    required this.snapshot,
    required this.index,
  });

  final String formattedDate;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: context.height / 5,
        decoration: BoxDecoration(
          borderRadius: context.normalBorderRadius,
        ),
        child: Padding(
          padding: context.paddingLow + context.verticalPaddingLow,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: context.height / 5,
                width: context.width / 5,
                decoration: BoxDecoration(
                  borderRadius: context.normalBorderRadius,
                  image: snapshot.data!.docs[index]
                              [FirestoreFieldConstants.imagePathField] ==
                          null
                      ? null
                      : DecorationImage(
                          image: NetworkImage(
                            snapshot.data!.docs[index]
                                [FirestoreFieldConstants.imagePathField],
                          ),
                        ),
                ),
              ),
              context.emptySizedWidthBoxLow3x,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.docs[index]
                          [FirestoreFieldConstants.titleField],
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      snapshot.data!.docs[index]
                          [FirestoreFieldConstants.descriptionField],
                      style: context.textTheme.labelMedium,
                      overflow: TextOverflow.clip,
                    ),
                    context.emptySizedHeightBoxLow,
                    Text(
                      formattedDate,
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
