import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biren_kocluk/features/admin/view/students/login_accept_view.dart';
import 'package:biren_kocluk/features/admin/view/students/mixin/login_requiest_operation_mixin.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/cross_check_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:biren_kocluk/product/widget/admin/cross_check_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginRequiestView extends StatefulWidget {
  const LoginRequiestView({super.key});

  @override
  State<LoginRequiestView> createState() => _LoginRequiestViewState();
}

class _LoginRequiestViewState extends State<LoginRequiestView>
    with LoginRequiestOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.features_loginRequests.tr()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  LocaleKeys.noDemand.tr(),
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
                      name(snapshot, index),
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
                                    name: name(snapshot, index),
                                    mail: mail(snapshot, index),
                                    password: password(snapshot, index),
                                    createdTime: createdTime(snapshot, index),
                                    isVerified: isVerified(snapshot, index),
                                    uid: snapshot.data!.docs[index]
                                        [FirestoreFieldConstants.uidField],
                                    classText: classText(snapshot, index),
                                    grade: grade(snapshot, index),
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
      title: LocaleKeys.areYouSure.tr(),
      desc: "${name(snapshot, index)} ${LocaleKeys.refuseMessage.tr()}",
      btnOkOnPress: () {
        deleteUser(snapshot, index);
      },
      btnOkText: LocaleKeys.yes.tr(),
      btnCancelText: LocaleKeys.giveUp.tr(),
      btnCancelOnPress: () {},
    );
  }

  CircleAvatar _avatar(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return CircleAvatar(
      backgroundColor: LightThemeColors.blazeOrange.withOpacity(.3),
      child: Text(
        name(snapshot, index).characters.first,
      ),
    );
  }
}
