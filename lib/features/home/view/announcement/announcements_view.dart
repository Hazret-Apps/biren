import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                return Card(
                  child: Container(
                    height: context.height / 5,
                    decoration: BoxDecoration(
                      borderRadius: context.normalBorderRadius,
                    ),
                    child: Padding(
                      padding: context.paddingLow,
                      child: Row(
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
                          context.emptySizedHeightBoxLow,
                          Text(snapshot.data!.docs[index]["title"])
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
