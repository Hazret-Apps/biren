import 'package:biren_kocluk/core/enum/cross_check_enum.dart';
import 'package:biren_kocluk/core/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/core/widget/admin/cross_check_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginRequiestView extends StatelessWidget {
  const LoginRequiestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giriş Talepleri"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollections.users.reference
            .where("isVerified", isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: _avatar(snapshot, index),
                  title: Text(
                    snapshot.data!.docs[index]["name"],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CrossOrTickContainer(
                        crossTickEnum: CrossTickEnum.cross,
                        onTap: () {},
                      ),
                      context.emptySizedWidthBoxLow,
                      CrossOrTickContainer(
                        crossTickEnum: CrossTickEnum.tick,
                        onTap: () {},
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: LightThemeColors.blazeOrange,
              ),
            );
          }
        },
      ),
    );
  }

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
