import 'package:biren_kocluk/features/admin/view/admin_home_view.dart';
import 'package:biren_kocluk/features/admin/view/attendance/provider/attendance_provider.dart';
import 'package:biren_kocluk/features/auth/register/view/register_view.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/home/view/homeview/home_view.dart';
import 'package:biren_kocluk/features/loading/loading_view.dart';
import 'package:biren_kocluk/features/reject/rejected_view.dart';
import 'package:biren_kocluk/features/wait/waiting_view.dart';
import 'package:biren_kocluk/product/constants/app_constants.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/language_manager.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/init/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  await _init();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? adminLogin = prefs.getBool("adminLogin") ?? false;
  _initSystemUi();
  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: AppConstants.LANG_ASSET_PATH,
      fallbackLocale: LanguageManager.instance.trLocale,
      child: Biren(adminLogin: adminLogin),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.currentUser == null ? null : await loadUserClass();
}

Future<void> loadUserClass() async {
  DocumentSnapshot<Object?> user = await FirebaseCollections.students.reference
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  String userClassName = await user[FirestoreFieldConstants.classField];
  var userClass = await FirebaseCollections.classes.reference
      .where(FirestoreFieldConstants.nameField, isEqualTo: userClassName)
      .get();
  AuthService.userClassId = userClass.docs.first.id;
}

void _initSystemUi() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: LightThemeColors.scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

class Biren extends StatelessWidget {
  const Biren({super.key, required this.adminLogin});
  final bool adminLogin;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AttendanceProvider(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: "Biren Koçluk",
        theme: LightTheme(context).theme,
        debugShowCheckedModeBanner: false,
        home: adminLogin
            ? const AdminHomeView()
            : FirebaseAuth.instance.currentUser != null
                ? StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseCollections.students.reference
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data?.exists ?? false) {
                          if (snapshot
                              .data![FirestoreFieldConstants.isVerifiedField]) {
                            return const HomeView();
                          } else if (snapshot.data![
                                  FirestoreFieldConstants.isVerifiedField] ==
                              false) {
                            return const WaitingView();
                          } else {
                            return const RejectedView();
                          }
                        }
                      }
                      return const LoadingView();
                    },
                  )
                : const RegisterView(),
      ),
    );
  }
}
