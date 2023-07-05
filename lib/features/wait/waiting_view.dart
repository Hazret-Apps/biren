import 'package:biren_kocluk/product/gen/assets.gen.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class WaitingView extends StatefulWidget {
  const WaitingView({super.key});

  @override
  State<WaitingView> createState() => _WaitingViewState();
}

class _WaitingViewState extends State<WaitingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.auth_waitingAcceptTitle.tr()),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.horizontalPaddingNormal,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.auth_waitingAcceptDescription.tr(),
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  Assets.icons.logo.path,
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
