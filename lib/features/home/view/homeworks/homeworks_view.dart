import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/homework_card_large.dart';
import 'package:biren_kocluk/product/widget/drawer/homework_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeworksView extends StatelessWidget {
  const HomeworksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const HomeworkDrawer(),
      appBar: AppBar(
        title: Text(LocaleKeys.features_activeHomeworks.tr()),
        actions: const [],
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseCollections.homeworks.reference
          .where("makeEnum", isEqualTo: "empty")
          .where(
            Filter.or(
              Filter(
                "assignedId",
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              ),
              Filter(
                "assignedId",
                isEqualTo: AuthService.userClassId,
              ),
            ),
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Hiç Ödev Yok"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return HomeworkCardLarge(
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
    );
  }
}
