import 'package:biren_kocluk/features/home/mixin/didnt_made_homeworks_operation_mixin.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/card/pushed_homework_card_large.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DidntMadeHomeworksView extends StatefulWidget {
  const DidntMadeHomeworksView({super.key});

  @override
  State<DidntMadeHomeworksView> createState() => _DidntMadeHomeworksViewState();
}

class _DidntMadeHomeworksViewState extends State<DidntMadeHomeworksView>
    with DidntMadeOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _Body(stream),
    );
  }

  AppBar _appBar() =>
      AppBar(title: Text(LocaleKeys.features_didntMadeHomeworks.tr()));
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
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Hiç Ödev Yok"),
                  );
                }
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
