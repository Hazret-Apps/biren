import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AnnouncementView extends StatefulWidget {
  const AnnouncementView({super.key});

  @override
  State<AnnouncementView> createState() => _AnnouncementViewState();
}

class _AnnouncementViewState extends State<AnnouncementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollections.announcement.reference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: context.horizontalPaddingNormal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DateTime dateTime = snapshot
                    .data!.docs[index][FirestoreFieldConstants.createdTimeField]
                    .toDate();

                final formattedDate = DateFormat("dd/MM/yyyy").format(
                  dateTime,
                );

                return _AnnouncementCard(
                  formattedDate: formattedDate,
                  snapshot: snapshot,
                  index: index,
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(LocaleKeys.features_announcements.tr()),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({
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
