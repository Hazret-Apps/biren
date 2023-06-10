import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/widget/card/coming_homeworks_card.dart';
import 'package:flutter/material.dart';

class HomeworksLogView extends StatelessWidget {
  const HomeworksLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ödevler")),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseCollections.homeworkPush.reference.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ComingHomeworkCardLarge(
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
      ),
    );
  }
}
