import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/student_pushed_homeworks_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PushedHomeworksView extends StatefulWidget {
  const PushedHomeworksView({super.key});

  @override
  State<PushedHomeworksView> createState() => _PushedHomeworksViewState();
}

class _PushedHomeworksViewState extends State<PushedHomeworksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.features_pushedHomeworks.tr()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollections.homeworkPush.reference
            .where("senderUserID",
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("makeEnum", isEqualTo: "pushed")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return StudentPushedHomeworkCard(
                  snapshot: snapshot,
                  index: index,
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
