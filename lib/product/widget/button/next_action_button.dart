import 'package:flutter/material.dart';

class NextActionButton extends StatelessWidget {
  const NextActionButton({
    super.key,
    required this.onTap,
    required this.color,
  });

  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.arrow_forward_rounded,
        color: color,
      ),
    );
  }
}
