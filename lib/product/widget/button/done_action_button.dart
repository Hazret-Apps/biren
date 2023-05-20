import 'package:flutter/material.dart';

class DoneActionButton extends StatelessWidget {
  const DoneActionButton({
    super.key,
    required this.color,
    required this.onTap,
  });

  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.done_rounded,
        size: 28,
        color: color,
      ),
    );
  }
}
