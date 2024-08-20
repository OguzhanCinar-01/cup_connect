part of 'home_view.dart';

class DessertTab extends StatelessWidget {
  const DessertTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<AuthService>(context).getDessertData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found.'));
          } else {
            final dessertList = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: dessertList.length,
              itemBuilder: (context, index) {
                final dessert = dessertList[index];
                return CoffeeGridItem(
                  imagePath: 'assets/images/dessert_brownie.png',
                  title: dessert['dessert_name'] ?? 'Unknown',
                  price: dessert['price'] as double,
                  description: dessert['description'] ?? 'Classic',
                );
              },
            );
          }
        });
  }
}