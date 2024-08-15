import 'package:coffee_shop/views/home/widget/coffee_grid_item.dart';
import 'package:flutter/material.dart';

class HotCoffeeTab extends StatelessWidget {
  const HotCoffeeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: const [
        CoffeeGridItem(
          imagePath: 'assets/images/hot_cappucino.png',
          title: 'Cappuccino',
          price: 4.99,
        ),
        CoffeeGridItem(
          imagePath: 'assets/images/hot_cappucino.png',
          title: 'Latte',
          price: 3.99,
        ),
        CoffeeGridItem(
          imagePath: 'assets/images/hot_cappucino.png',
          title: 'Latte',
          price: 3.99,
        ),
        CoffeeGridItem(
          imagePath: 'assets/images/hot_cappucino.png',
          title: 'Latte',
          price: 3.99,
        ),
        CoffeeGridItem(
          imagePath: 'assets/images/hot_cappucino.png',
          title: 'Latte',
          price: 3.99,
        ),
        CoffeeGridItem(
          imagePath: 'assets/images/hot_cappucino.png',
          title: 'Latte',
          price: 3.99,
        ),
      ],
    );
  }
}
