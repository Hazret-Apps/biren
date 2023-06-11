import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeworkSearchView extends StatelessWidget {
  const HomeworkSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.search_rounded),
          ),
          context.emptySizedWidthBoxNormal,
        ],
      ),
    );
  }
}
