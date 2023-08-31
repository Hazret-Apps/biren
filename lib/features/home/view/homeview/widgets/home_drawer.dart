import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/home/view/announcement/announcements_view.dart';
import 'package:biren_kocluk/features/home/view/attendance/attendance_view.dart';
import 'package:biren_kocluk/features/home/view/exams/exams_view.dart';
import 'package:biren_kocluk/features/home/view/homeworks/homeworks_view.dart';
import 'package:biren_kocluk/features/home/view/profile/profile_view.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class HomeViewDrawer extends StatelessWidget {
  const HomeViewDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: LightThemeColors.white,
      child: ListView(
        padding: context.verticalPaddingMedium,
        children: [
          context.emptySizedHeightBoxLow3x,
          _HomeViewListTile(
            "Profil",
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ProfileView(),
                ),
              );
            },
            Icons.account_circle_rounded,
          ),
          _HomeViewListTile(
            LocaleKeys.features_homeworks.tr(),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const HomeworksView(),
                ),
              );
            },
            Icons.business_center_rounded,
          ),
          _HomeViewListTile(
            LocaleKeys.features_announcements.tr(),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AnnouncementView(),
                ),
              );
            },
            FontAwesomeIcons.triangleExclamation,
          ),
          _HomeViewListTile(
            LocaleKeys.features_attendance.tr(),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AttendanceView(),
                ),
              );
            },
            Icons.calendar_month_rounded,
          ),
          _HomeViewListTile(
            LocaleKeys.features_exams.tr(),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ExamsView(),
                ),
              );
            },
            Icons.auto_graph_rounded,
          ),
          _HomeViewListTile(
            LocaleKeys.auth_logOut.tr(),
            () {
              _signOutConfirmDialog(context).show();
            },
            Icons.exit_to_app_rounded,
          )
        ],
      ),
    );
  }

  AwesomeDialog _signOutConfirmDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      desc: LocaleKeys.auth_logOutSubmitText.tr(),
      btnOkText: LocaleKeys.yes.tr(),
      btnOkOnPress: () {
        AuthService().logOut(context);
        Navigator.pop(context);
        final snackBar = _snackBar();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      },
      btnOkColor: LightThemeColors.red,
    );
  }

  SnackBar _snackBar() {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: LocaleKeys.auth_logOutSuccess.tr(),
        message: LocaleKeys.auth_logOutSuccessText.tr(),
        contentType: ContentType.success,
      ),
    );
  }
}

class _HomeViewListTile extends StatelessWidget {
  const _HomeViewListTile(this.title, this.onTap, this.icon);
  final String title;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
