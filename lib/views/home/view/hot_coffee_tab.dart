part of 'home_view.dart';

class _HotCoffeeTab extends StatelessWidget {
  const _HotCoffeeTab();

  @override
  Widget build(BuildContext context) {
    final productDataViewModel = Provider.of<ProductDataViewModel>(context);
    // If hot coffee list is empty, fetch the data
    if (productDataViewModel.hotCoffeeList.isEmpty) {
      productDataViewModel.getHotCoffeeData();
    }
    return productDataViewModel.hotCoffeeList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: productDataViewModel.hotCoffeeList.length,
            itemBuilder: (context, index) {
              final hotCoffee = productDataViewModel.hotCoffeeList[index];
              return CoffeeGridItem(
                imagePath: 'assets/images/hot_${hotCoffee['imgPath']}.png',
                title: hotCoffee['coffee_name'] ?? 'Unknown',
                price: (hotCoffee['price'] as double),
                description: hotCoffee['descriptions'] ?? 'No Data',
                coffeSize: hotCoffee['coffee_size'],
              );
            },
          );
  }
}
