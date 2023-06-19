import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                final DateTime dateTime =
                    snapshot.data!.docs[index]["createdTime"].toDate();

                final formattedDate = DateFormat("dd/MM/yyyy").format(
                  dateTime,
                );

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
                              image: DecorationImage(
                                image: NetworkImage(
                                  snapshot.data!.docs[index]["imagePath"],
                                ),
                              ),
                            ),
                          ),
                          context.emptySizedWidthBoxLow3x,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.docs[index]["title"]),
                              Text(
                                snapshot.data!.docs[index]["description"],
                                style: context.textTheme.labelMedium,
                              ),
                              context.emptySizedHeightBoxLow,
                              Text(
                                formattedDate,
                                style: context.textTheme.labelMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
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
      title: const Text("Duyurular"),
    );
  }
}
