import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  AwesomeDialog _rejectDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: LocaleKeys.areYouSure.tr(),
      desc: "Hesabını Silmek İstediğinden Emin misin!",
      btnOkOnPress: () {
        AuthService().deleteAccount(context);
      },
      btnOkText: LocaleKeys.yes.tr(),
      btnCancelText: LocaleKeys.giveUp.tr(),
      btnCancelOnPress: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: StreamBuilder(
        stream: FirebaseCollections.students.reference
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                CircleAvatar(
                  backgroundColor: LightThemeColors.blazeOrangeLight,
                  radius: 100,
                  child: Text(
                    snapshot.data![FirestoreFieldConstants.nameField]
                        .toString()
                        .characters
                        .first,
                    style: context.textTheme.displayLarge?.copyWith(
                      color: LightThemeColors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
                context.emptySizedHeightBoxLow3x,
                Center(
                  child: Text(
                    snapshot.data![FirestoreFieldConstants.nameField],
                    style: context.textTheme.displayLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                context.emptySizedHeightBoxLow,
              ],
            );
          } else {
            return const _LoadingWidget();
          }
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: context.height / 5,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            _rejectDialog(context).show();
                          },
                          child: const Text(
                            "Hesabı Sil",
                            style: TextStyle(color: LightThemeColors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.settings_rounded),
        ),
        context.emptySizedWidthBoxNormal,
      ],
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
