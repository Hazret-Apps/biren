import 'package:flutter/material.dart';

class LanguageManager {
  LanguageManager._init();

  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  final trLocale = const Locale("tr", "TR");

  List<Locale> get supportedLocales => [trLocale];
}
