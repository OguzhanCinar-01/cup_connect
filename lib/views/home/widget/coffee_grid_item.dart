import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/product/view/product_view.dart';
import 'package:coffee_shop/views/product/viewmodel/product_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
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
    required this.coffeSize,
  });

  final String imagePath;
  final String title;
  final double price;
  final String description;
  final String coffeSize;

  @override
  Widget build(BuildContext context) {
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
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 3),
                  width: MediaQuery.of(context).size.width * 0.27,
                  height: MediaQuery.of(context).size.height * 0.086,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              5.h,
              /// title
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: GoogleFonts.lato(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              /// Description
              /* Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  description,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),*/ 

              /// Price
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 5,
                ),
                child: Row(
                  children: [
                    Text(
                      '\$ $price',
                      style: const TextStyle(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    const Spacer(),

                    /// FAB
                    FloatingActionButton(
                      onPressed: () {
                        /// When tapped, add the item to the cart
                        ///
                      },
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      mini: true,
                      child: const Icon(Icons.add, color: AppColors.surface),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
