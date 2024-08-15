part of 'home_view.dart';

class _HotCoffeeTab extends StatelessWidget {
  const _HotCoffeeTab();

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
