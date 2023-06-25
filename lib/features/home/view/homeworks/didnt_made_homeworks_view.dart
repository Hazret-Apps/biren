import 'package:biren_kocluk/features/home/mixin/didnt_made_homeworks_operation_mixin.dart';
import 'package:biren_kocluk/product/widget/card/pushed_homework_card_large.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  AppBar _appBar() => AppBar(title: const Text("Yapılmayan Ödevler"));
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
