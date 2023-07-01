import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/home/view/announcement/announcements_view.dart';
import 'package:biren_kocluk/features/home/view/attendance/attendance_view.dart';
import 'package:biren_kocluk/features/home/view/exams/exams_view.dart';
import 'package:biren_kocluk/features/home/view/homeworks/homeworks_view.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: LightThemeColors.blazeOrange,
            ),
            height: context.height / 7,
            child: Padding(
              padding: context.verticalPaddingMedium +
                  context.horizontalPaddingNormal,
              child: Text(
                "Biren Koçluk",
                style: context.textTheme.displaySmall?.copyWith(
                  color: LightThemeColors.white,
                ),
              ),
            ),
          ),
          _HomeViewListTile(
            "Ödevler",
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
            "Duyurular",
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
            "Yoklama",
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
            "Denemeler",
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
            "Çıkış Yap",
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
      desc: "Çıkış Yapmak İstediğinden Emin misin?",
      btnOkText: "EVET",
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
        title: "Çıkış Yapıldı",
        message: "Çıkış Yapma İşlemi Başarılı",
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
