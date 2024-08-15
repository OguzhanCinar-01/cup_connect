import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:flutter/material.dart';

class CoffeeGridItem extends StatelessWidget {
  const CoffeeGridItem(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.price});

  final String imagePath;
  final String title;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade400,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 100),
              Text(title),
              2.h,
              Text('\$ $price'),
            ],
          ),
        ),
      ),
    );
  }
}
