part of 'home_view.dart';

class ColdCoffeeTab extends StatelessWidget {
  const ColdCoffeeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<AuthService>(context).getColdCoffeeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found.'));
          } else {
            final coldCoffeeList = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: coldCoffeeList.length,
              itemBuilder: (context, index) {
                final coldCoffee = coldCoffeeList[index];
                return CoffeeGridItem(
                  imagePath: 'assets/images/hot_cappucino.png',
                  title: coldCoffee['coffee_name'] ?? 'Unknown',
                  price: coldCoffee['price'] as double,
                  description: coldCoffee['descriptions'] ?? 'Classic',
                  coffeSize: coldCoffee['coffee_size'],
                );
              },
            );
          }
        });
  }
}
