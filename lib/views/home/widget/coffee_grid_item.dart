import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/product/view/product_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../extensions/space_exs.dart';
import 'package:flutter/material.dart';

class CoffeeGridItem extends StatelessWidget {
  const CoffeeGridItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.description,
  });

  final String imagePath;
  final String title;
  final double price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: GestureDetector(
        onTap: () {
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
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Image.asset(
                  imagePath,
                  height: 75,
                  width: 130,
                ),
              ),
              5.h,
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
              /*Padding(
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
