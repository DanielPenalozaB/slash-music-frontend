import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double? height;

  const BasicAppButton({
    required this.onPressed,
    required this.label,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 60),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
