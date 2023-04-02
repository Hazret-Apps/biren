import 'package:biren_kocluk/core/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/core/gen/assets.gen.dart';
import 'package:biren_kocluk/features/empty/empty_view.dart';
import 'package:biren_kocluk/features/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return StreamBuilder(
      stream: FirebaseCollections.users.reference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data?["isVerified"] == false) {
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
                        Assets.icons.icon.path,
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (snapshot.data?["isVerified"] ?? false) {
          return const HomeView();
        } else {
          return const EmptyView();
        }
      },
    );
  }
}