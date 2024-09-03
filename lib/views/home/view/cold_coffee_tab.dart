part of 'home_view.dart';

class ColdCoffeeTab extends StatelessWidget {
  const ColdCoffeeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final productDataViewModel = Provider.of<ProductDataViewModel>(context);
    final searchQuery = Provider.of<SearchViewModel>(context).searchQuery;

    /// If cold coffee list is empty, fetch the data
    if (productDataViewModel.coldCoffeeList.isEmpty) {
      productDataViewModel.getColdCoffeeData();
    }

    /// Filter the cold coffee list based on the search query
    final filteredList = productDataViewModel.coldCoffeeList.where((coffee) {
      final coffeeName = coffee['coffee_name']?.toLowerCase() ?? '';
      return coffeeName.contains(searchQuery.toLowerCase());
    }).toList();

    return productDataViewModel.coldCoffeeList.isEmpty
        ? const Center(child: CircularProgressIndicator())
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
                  final coldCoffee = filteredList[index];
                  return CoffeeGridItem(
                    imagePath:
                        'assets/images/cold_${coldCoffee['imgPath']}.png',
                    title: coldCoffee['coffee_name'] ?? 'Unknown',
                    price: (coldCoffee['price'] as double),
                    description: coldCoffee['descriptions'] ?? 'No Data',
                    coffeSize: coldCoffee['coffee_size'],
                  );
                },
              );
  }
}
