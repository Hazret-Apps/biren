import 'package:biren_kocluk/features/admin/view/homework/mixin/admin_all_homeworks_operation_mixin.dart';
import 'package:biren_kocluk/product/widget/card/pushed_homework_card_large.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  AppBar get _appBar => AppBar(title: const Text("Tüm Ödevler"));
}
