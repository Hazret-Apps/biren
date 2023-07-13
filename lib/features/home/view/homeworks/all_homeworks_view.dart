import 'package:biren_kocluk/features/home/mixin/all_homeworks_operation_mixin.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/pushed_homework_card_large.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AllHomeworksView extends StatefulWidget {
  const AllHomeworksView({super.key});

  @override
  State<AllHomeworksView> createState() => _AllHomeworksViewState();
}

class _AllHomeworksViewState extends State<AllHomeworksView>
    with AllHomeworksOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Hiç Ödev Yok"),
                  );
                }
                return PushedHomeworkCardLarge(
                  snapshot: snapshot,
                  index: index,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }

  AppBar get _appBar =>
      AppBar(title: Text(LocaleKeys.features_homeworkHistory.tr()));
}
