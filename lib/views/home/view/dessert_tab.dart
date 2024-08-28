part of 'home_view.dart';

class DessertTab extends StatelessWidget {
  const DessertTab({super.key});

  @override
  Widget build(BuildContext context) {
    final productDataViewModel = Provider.of<ProductDataViewModel>(context);

    /// If dessert list is empty, fetch the data
    if (productDataViewModel.dessertList.isEmpty) {
      productDataViewModel.getDessertData();
    }
    return productDataViewModel.dessertList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: productDataViewModel.dessertList.length,
            itemBuilder: (context, index) {
              final dessert = productDataViewModel.dessertList[index];
              return CoffeeGridItem(
                imagePath: 'assets/images/dessert_${dessert['imgPath']}.png',
                title: dessert['dessert_name'] ?? 'Unknown',
                price: (dessert['price'] as double),
                description: dessert['descriptions'] ?? 'No Data',
              );
            },
          );
  }
}
