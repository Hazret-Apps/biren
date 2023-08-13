import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class DidntCameDaysView extends StatefulWidget {
  const DidntCameDaysView({super.key});

  @override
  State<DidntCameDaysView> createState() => _DidntCameDaysViewState();
}

class _DidntCameDaysViewState extends State<DidntCameDaysView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: StreamBuilder(
        stream: FirebaseCollections.students.reference
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("attendance")
            .where(
              FirestoreFieldConstants.statusField,
              isEqualTo: "didntCame",
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final Timestamp date = snapshot.data!.docs[index]
                    [FirestoreFieldConstants.dateField];
                String formattedDate =
                    DateFormat('dd MMMM', 'tr_TR').format(date.toDate());

                return ListTile(
                  title: Row(
                    children: [
                      Text("$formattedDate :",
                          style: context.textTheme.bodyMedium),
                      const Spacer(),
                      Text(LocaleKeys.didntCame.tr(),
                          style: context.textTheme.bodyMedium),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }

  AppBar _appBar() => AppBar(title: const Text("Gelinmeyen Günler"));
}
