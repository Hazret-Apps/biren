import 'package:flutter/material.dart';

class RejectedView extends StatelessWidget {
  const RejectedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Giriş Talebiniz Reddedildi"),
      ),
    );
  }
}
