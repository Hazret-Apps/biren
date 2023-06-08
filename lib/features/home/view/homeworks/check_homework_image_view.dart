import 'dart:io';

import 'package:flutter/material.dart';

class CheckHomeworkImageView extends StatelessWidget {
  const CheckHomeworkImageView({super.key, required this.image});
  final File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Image.file(image),
        ],
      ),
    );
  }
}
