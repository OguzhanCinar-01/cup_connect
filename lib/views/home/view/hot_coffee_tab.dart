part of 'home_view.dart';

class _HotCoffeeTab extends StatelessWidget {
  const _HotCoffeeTab();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<AuthService>(context).getHotCoffeeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found.'));
          } else {
            final hotcoffeeList = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: hotcoffeeList.length,
              itemBuilder: (context, index) {
                final hotCoffee = hotcoffeeList[index];
                return CoffeeGridItem(
                  imagePath: 'assets/images/hot_cappucino.png',
                  title: hotCoffee['coffee_name'] ?? 'Unknown',
                  price: hotCoffee['price'] as double,
                  description: hotCoffee['description'] ?? 'Classic',
                );
              },
            );
          }
        });
  }
}
