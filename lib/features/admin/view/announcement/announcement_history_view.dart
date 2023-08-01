import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/announcement_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AnnouncementHistoryView extends StatelessWidget {
  const AnnouncementHistoryView({super.key});

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
                return AnnouncementCard(
                  formattedDate: formattedDate,
                  snapshot: snapshot,
                  index: index,
                  isAdmin: true, 
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }

  AppBar _appBar() =>
      AppBar(title: Text(LocaleKeys.features_announcementHistory.tr()));
}
