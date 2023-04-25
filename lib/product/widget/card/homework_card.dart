import 'package:biren_kocluk/product/model/homework_model.dart';
import 'package:flutter/material.dart';

class HomeworkItem extends StatelessWidget {
  final Homework event;
  const HomeworkItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        event.title,
      ),
      subtitle: Text(
        event.description ?? "",
      ),
    );
  }
}
