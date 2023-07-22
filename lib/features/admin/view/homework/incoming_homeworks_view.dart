import 'package:biren_kocluk/features/admin/view/homework/mixin/incoming_homeworks_operation_mixin.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/admin/admin_homework_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IncomingHomeworksView extends StatefulWidget {
  const IncomingHomeworksView({super.key});

  @override
  State<IncomingHomeworksView> createState() => _IncomingHomeworksViewState();
}

class _IncomingHomeworksViewState extends State<IncomingHomeworksView>
    with IncomingHomeworksOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _Body(stream),
    );
  }

  AppBar get _appBar =>
      AppBar(title: Text(LocaleKeys.features_incomingHomeworks.tr()));
}

class _Body extends StatelessWidget {
  const _Body(this.stream);
  final Stream<QuerySnapshot> stream;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return AdminAllHomeworkCard(
                  snapshot: snapshot,
                  index: index,
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
