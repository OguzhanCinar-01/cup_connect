import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Card(
        color: AppColors.secondary,
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
              ),
              leading: Icon(icon),
              onTap: () {
                onTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}
