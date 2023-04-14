import 'package:biren_kocluk/core/base/view/base_view.dart';
import 'package:biren_kocluk/core/enum/admin_feature_types.dart';
import 'package:biren_kocluk/core/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/core/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/core/widget/card/announcement_card.dart';
import 'package:biren_kocluk/core/widget/card/feature_select_card.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/home/viewmodel/home_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (model) {},
      viewModel: HomeViewModel(),
      onPageBuilder: (context, value) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                AuthService().logOut(context);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: LightThemeColors.black,
              ),
            ),
          ],
          title: Text(
            "${LocaleKeys.hello.tr()}\n${AuthService.userName} 👋",
            style: context.textTheme.titleLarge?.copyWith(
              color: LightThemeColors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseCollections.announcement.reference.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AnnouncementCard(querySnapshot: snapshot);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              context.emptySizedHeightBoxLow3x,
              Padding(
                padding: context.horizontalPaddingNormal,
                child: const Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FeatureSelectCard(
                          featureTypes: FeatureTypes.task,
                        ),
                        Spacer(),
                        FeatureSelectCard(
                          featureTypes: FeatureTypes.study,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
