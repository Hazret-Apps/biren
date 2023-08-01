import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.formattedDate,
    required this.snapshot,
    required this.index,
    required this.isAdmin,
  });

  final String formattedDate;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: context.height / 4.7,
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
                    isAdmin
                        ? Row(
                            children: [
                              Text(
                                snapshot.data!.docs[index]
                                    [FirestoreFieldConstants.titleField],
                                overflow: TextOverflow.clip,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    title: "Uyarı!",
                                    desc:
                                        "Bu duyuruyu kalıcı olarak silmek istediğinizden emin misiniz?",
                                    btnOkText: "Sil",
                                    btnOkColor: LightThemeColors.red,
                                    btnOkOnPress: () {
                                      FirebaseCollections.announcement.reference
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete();
                                    },
                                  ).show();
                                },
                                icon: const Icon(Icons.delete_forever_rounded),
                              )
                            ],
                          )
                        : Text(
                            snapshot.data!.docs[index]
                                [FirestoreFieldConstants.titleField],
                            overflow: TextOverflow.clip,
                          ),
                    Text(
                      snapshot.data!.docs[index]
                          [FirestoreFieldConstants.descriptionField],
                      style: context.textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
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
