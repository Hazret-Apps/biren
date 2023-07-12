import 'package:biren_kocluk/features/home/mixin/missing_homeworks_operation_mixin.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/pushed_homework_card_large.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MissingHomeworksView extends StatefulWidget {
  const MissingHomeworksView({super.key});

  @override
  State<MissingHomeworksView> createState() => _MissingHomeworksViewState();
}

class _MissingHomeworksViewState extends State<MissingHomeworksView>
    with MissingHomeworksOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _Body(stream),
    );
  }

  AppBar _appBar() =>
      AppBar(title: Text(LocaleKeys.features_missingHomeworks.tr()));
}

class _Body extends StatelessWidget {
  const _Body(this.stream);
  final Stream<QuerySnapshot> stream;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return PushedHomeworkCardLarge(
                  index: index,
                  snapshot: snapshot,
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
