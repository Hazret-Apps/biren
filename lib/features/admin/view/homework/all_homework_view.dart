import 'package:biren_kocluk/features/admin/view/homework/mixin/all_homeworks_operation_mixin.dart';
import 'package:biren_kocluk/product/widget/card/all_homework_card_large.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllHomeworks extends StatefulWidget {
  const AllHomeworks({super.key});

  @override
  State<AllHomeworks> createState() => _AllHomeworksState();
}

class _AllHomeworksState extends State<AllHomeworks>
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
                return AllHomeworkCardLarg(
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

  AppBar get _appBar => AppBar(title: const Text("Geçmiş Ödevler"));
}
