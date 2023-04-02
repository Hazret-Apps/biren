import 'package:biren_kocluk/core/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/core/widget/card/announcement_card.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Merhaba\n${AuthService.userName} 👋",
          style: context.textTheme.titleLarge?.copyWith(
            color: LightThemeColors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.emptySizedHeightBoxLow,
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseCollections.announcement.reference.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AnnouncementCard(querySnapshot: snapshot);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
