import 'package:biren_kocluk/core/init/theme/theme.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => LightTheme().theme;
  TextTheme get textTheme => LightTheme().theme.textTheme;
}
