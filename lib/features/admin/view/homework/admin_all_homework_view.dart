import 'package:biren_kocluk/features/admin/view/homework/mixin/admin_all_homeworks_operation_mixin.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/admin/admin_homework_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AdminAllHomeworksView extends StatefulWidget {
  const AdminAllHomeworksView({super.key});

  @override
  State<AdminAllHomeworksView> createState() => _AdminAllHomeworksViewState();
}

class _AdminAllHomeworksViewState extends State<AdminAllHomeworksView>
    with AdminAllHomeworksOperationMixin {
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
                return AdminAllHomeworkCard(
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
      AppBar(title: Text(LocaleKeys.features_allHomeworks.tr()));
}
