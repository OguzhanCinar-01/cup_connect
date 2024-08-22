import 'package:flutter/material.dart';

class QuantityButtons extends StatelessWidget {
  const QuantityButtons({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
      ),
      onPressed: onPressed,
    );
  }
}
