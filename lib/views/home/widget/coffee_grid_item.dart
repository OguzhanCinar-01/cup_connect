import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:coffee_shop/views/product/view/product_view.dart';
import 'package:coffee_shop/views/product/viewmodel/product_view_model.dart';
import 'package:provider/provider.dart';

import '../../../extensions/space_exs.dart';
import 'package:flutter/material.dart';

class CoffeeGridItem extends StatelessWidget {
  const CoffeeGridItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.description,
    this.coffeSize = '',

    /// Default size if not provided
    this.syrup = 'Classic',

    /// Default syrup
  });

  final String imagePath;
  final String title;
  final double price;
  final String description;
  final String coffeSize;
  final String syrup;

  @override
  Widget build(BuildContext context) {
    final fixedPrice = price.toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GestureDetector(
        onTap: () {
          /// When tapped, select the product and navigate to the product view
          final selectedProduct = Product(
            name: title,
            description: description,
            price: price,
            imagePath: imagePath,
            coffeeSize: coffeSize,
            syrup: syrup,
          );

          Provider.of<ProductViewModel>(context, listen: false)
              .selectProduct(selectedProduct);

          /// Navigate to the product view
          NavigationManager.instance.navigateToPage(const ProductView());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              2.h,

              /// Image container
              _imageContainer(context),
              5.h,

              /// Title
              _productTitleText(),

              /// Price and FAB
              _priceText(fixedPrice, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageContainer(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 3),
        width: MediaQuery.of(context).size.width * 0.27,
        height: MediaQuery.of(context).size.height * 0.095,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _productTitleText() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: AppStyle.priceTextStyle,
      ),
    );
  }

  Widget _priceText(String fixedPrice, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 5,
      ),
      child: Row(
        children: [
          Text(
            '\$ $fixedPrice',
            style: AppStyle.price,
          ),

          const Spacer(),

          /// FAB
          FloatingActionButton(
            onPressed: () {
              /// When tapped, add the item to the cart
              final newOrder = Order(
                productName: title,
                price: price,
                size: coffeSize,
              );
              print('Order: ${newOrder.syrup}');

              // Add the order to OrderViewModel
              Provider.of<OrderViewModel>(context, listen: false)
                  .addOrder(newOrder);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${newOrder.productName} added to cart.'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            backgroundColor: AppColors.primary,
            elevation: 0,
            mini: true,
            child: const Icon(Icons.add, color: AppColors.surface),
          ),
        ],
      ),
    );
  }
}
