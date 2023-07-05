import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RejectedView extends StatelessWidget {
  const RejectedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(LocaleKeys.auth_loginRejected.tr()),
      ),
    );
  }
}
