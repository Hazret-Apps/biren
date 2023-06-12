import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biren_kocluk/features/admin/view/students/login_accept_view.dart';
import 'package:biren_kocluk/product/enum/cross_check_enum.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:biren_kocluk/product/widget/admin/cross_check_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
        stream: FirebaseCollections.students.reference
            .where("isVerified", isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "Bir Talep Yok",
                  style: context.textTheme.titleLarge,
                ),
              );
            } else {
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
                        CrossTickContainer(
                          onTap: () {
                            _rejectDialog(context, snapshot, index).show();
                          },
                          crossTickEnum: CrossTickEnum.cross,
                        ),
                        context.emptySizedWidthBoxLow3x,
                        CrossTickContainer(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => LoginAcceptView(
                                  userModel: UserModel(
                                    name: snapshot.data!.docs[index]["name"],
                                    mail: snapshot.data!.docs[index]["mail"],
                                    password: snapshot.data!.docs[index]
                                        ["password"],
                                    createdTime: snapshot.data!.docs[index]
                                        ["createdTime"],
                                    isVerified: snapshot.data!.docs[index]
                                        ["isVerified"],
                                    uid: snapshot.data!.docs[index]["uid"],
                                    classText: snapshot.data!.docs[index]
                                        ["class"],
                                    grade: snapshot.data!.docs[index]["grade"],
                                  ),
                                ),
                              ),
                            );
                          },
                          crossTickEnum: CrossTickEnum.tick,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
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

  AwesomeDialog _rejectDialog(BuildContext context,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: "Emin misin?",
      desc:
          "${snapshot.data!.docs[index]["name"]} adlı kişiyi reddetmek istediğinizden emin misiniz?",
      btnOkOnPress: () {
        FirebaseCollections.students.reference
            .doc(snapshot.data!.docs[index]["uid"])
            .delete();
      },
      btnOkText: "Evet",
      btnCancelText: "Vazgeç",
      btnCancelOnPress: () {},
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
