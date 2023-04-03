import 'package:biren_kocluk/core/constants/app_constants.dart';
import 'package:biren_kocluk/core/init/lang/language_manager.dart';
import 'package:biren_kocluk/core/init/theme/theme.dart';
import 'package:biren_kocluk/features/auth/register/view/register_view.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/empty/empty_view.dart';
import 'package:biren_kocluk/features/home/home_view.dart';
import 'package:biren_kocluk/features/home/view/wait/waiting_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await _init();
  _initSystemUi();
  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: AppConstants.LANG_ASSET_PATH,
      fallbackLocale: LanguageManager.instance.trLocale,
      child: const Biren(),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
}

void _initSystemUi() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

class Biren extends StatelessWidget {
  const Biren({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Biren Koçluk',
      theme: LightTheme(context).theme,
      debugShowCheckedModeBanner: false,
      home: AuthService.userId == null
          ? RegisterView()
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(AuthService.userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const EmptyView();
                }
                if (snapshot.hasData) {
                  if (snapshot.data!["isVerified"]) {
                    return const HomeView();
                  }
                  return const WaitingView();
                }
                return const EmptyView();
              },
            ),
    );
  }
}
