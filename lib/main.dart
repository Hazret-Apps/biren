import 'package:biren_kocluk/core/init/theme/theme.dart';
import 'package:biren_kocluk/features/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  _initSystemUi();
  runApp(const MyApp());
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biren Koçluk',
      theme: LightTheme().theme,
      debugShowCheckedModeBanner: false,
      home: const Biren(),
    );
  }
}

class Biren extends StatelessWidget {
  const Biren({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}
