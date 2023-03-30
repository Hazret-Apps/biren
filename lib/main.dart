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
      statusBarIconBrightness: Brightness.dark,
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
    return const MaterialApp(
      title: 'Biren Koçluk',
      debugShowCheckedModeBanner: false,
      home: Biren(),
    );
  }
}

class Biren extends StatelessWidget {
  const Biren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "BİREN KOÇLUK",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: const Color(0xfffc6406),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
