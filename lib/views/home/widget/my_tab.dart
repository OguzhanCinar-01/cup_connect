import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  const MyTab({super.key, required this.iconPath, required this.title});
  final String iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 42,
              height: 40,
            ),
             Expanded(
               child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                           ),
             ),
          ],
        ),
      ),
    );
  }
}