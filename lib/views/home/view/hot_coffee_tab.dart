part of 'home_view.dart';

class _HotCoffeeTab extends StatelessWidget {
  const _HotCoffeeTab();

  @override
  Widget build(BuildContext context) {
    final productDataViewModel = Provider.of<ProductDataViewModel>(context);
    final searchQuery = Provider.of<SearchViewModel>(context).searchQuery;

    // If hot coffee list is empty, fetch the data
    if (productDataViewModel.hotCoffeeList.isEmpty) {
      productDataViewModel.getHotCoffeeData();
    }

    /// Filter the hot coffee list based on the search query
    final filteredList = productDataViewModel.hotCoffeeList.where((coffee) {
      final coffeeName = coffee['coffee_name']?.toLowerCase() ?? '';
      return coffeeName.contains(searchQuery.toLowerCase());
    }).toList();

    return productDataViewModel.hotCoffeeList.isEmpty
        ? const Center(child: MyCircularProgressIndicator())
        : filteredList.isEmpty
            ? const Center(
                child: Text('No result Found', style: TextStyle(fontSize: 20)))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final hotCoffee = filteredList[index];
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
