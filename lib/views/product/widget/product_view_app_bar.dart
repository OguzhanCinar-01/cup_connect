import 'package:flutter/material.dart';

class ProductViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
    @override
  Size get preferredSize => const Size.fromHeight(80);
}