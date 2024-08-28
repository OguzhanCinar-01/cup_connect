part of 'home_view.dart';

class ColdCoffeeTab extends StatelessWidget {
  const ColdCoffeeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final productDataViewModel = Provider.of<ProductDataViewModel>(context);

    /// If cold coffee list is empty, fetch the data
    if (productDataViewModel.coldCoffeeList.isEmpty) {
      productDataViewModel.getColdCoffeeData();
    }
    return productDataViewModel.coldCoffeeList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: productDataViewModel.coldCoffeeList.length,
            itemBuilder: (context, index) {
              final coldCoffee = productDataViewModel.coldCoffeeList[index];
              return CoffeeGridItem(
                imagePath: 'assets/images/cold_${coldCoffee['imgPath']}.png',
                title: coldCoffee['coffee_name'] ?? 'Unknown',
                price: (coldCoffee['price'] as double),
                description: coldCoffee['descriptions'] ?? 'No Data',
                coffeSize: coldCoffee['coffee_size'],
              );
            },
          );
  }
}
