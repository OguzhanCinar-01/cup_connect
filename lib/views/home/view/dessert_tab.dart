part of 'home_view.dart';

class DessertTab extends StatelessWidget {
  const DessertTab({super.key});

  @override
  Widget build(BuildContext context) {
    final productDataViewModel = Provider.of<ProductDataViewModel>(context);
    final searchQuery = Provider.of<SearchViewModel>(context).searchQuery;

    /// If dessert list is empty, fetch the data
    if (productDataViewModel.dessertList.isEmpty) {
      productDataViewModel.getDessertData();
    }

    /// Filter the dessert list based on the search query
    final filteredList = productDataViewModel.dessertList.where((dessert) {
      final dessertName = dessert['dessert_name']?.toLowerCase() ?? '';
      return dessertName.contains(searchQuery.toLowerCase());
    }).toList();
    return productDataViewModel.dessertList.isEmpty
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
                  final dessert = filteredList[index];
                  return CoffeeGridItem(
                    imagePath:
                        'assets/images/dessert_${dessert['imgPath']}.png',
                    title: dessert['dessert_name'] ?? 'Unknown',
                    price: (dessert['price'] as double),
                    description: dessert['descriptions'] ?? 'No Data',
                  );
                },
              );
  }
}
