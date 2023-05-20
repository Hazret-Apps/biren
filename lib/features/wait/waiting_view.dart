import 'package:biren_kocluk/product/gen/assets.gen.dart';
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
        title: const Text("İçeri alınmayı bekliyorsunuz"),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.horizontalPaddingNormal,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Giriş yapma talebiniz yöneticiye gönderilmiştir. Lütfen yöneticinin sizi içeri almasını bekleyiniz.",
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
