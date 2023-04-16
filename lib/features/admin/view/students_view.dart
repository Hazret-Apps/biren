import 'package:biren_kocluk/core/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentsView extends StatelessWidget {
  const StudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıtlı Öğrenciler"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollections.users.reference
            .where("isVerified", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: _userName(snapshot, index),
                  leading: _avatar(snapshot, index),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_forever,
                      color: LightThemeColors.red,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Text _userName(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) =>
      Text(snapshot.data!.docs[index]["name"]);

  CircleAvatar _avatar(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return CircleAvatar(
      backgroundColor: LightThemeColors.blazeOrange.withOpacity(.3),
      child: Text(
        snapshot.data!.docs[index]["name"].toString().characters.first,
      ),
    );
  }
}
