import 'package:biren_kocluk/core/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/loading/loading_view.dart';
import 'package:biren_kocluk/features/reject/rejected_view.dart';
import 'package:biren_kocluk/gen/assets.gen.dart';
import 'package:biren_kocluk/features/home/view/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseCollections.users.reference
          .doc(AuthService.userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.exists ?? false) {
            if (snapshot.data!["isVerified"]) {
              return const HomeView();
            } else {
              return _waiting(context);
            }
          } else {
            return const RejectedView();
          }
        }
        return const LoadingView();
      },
    );
  }

  Scaffold _waiting(BuildContext context) {
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
}
