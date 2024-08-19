import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_strings.dart';
import 'package:coffee_shop/views/product/widget/add_to_cart_button.dart';
import 'package:coffee_shop/views/product/widget/go_back_button.dart';
import 'package:coffee_shop/views/product/widget/size_button.dart';
import 'package:coffee_shop/views/product/widget/syrup_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Go back button
            const GoBackButton(),

            /// Product image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                color: Colors.grey.shade200,
                child: Image.asset(
                  'assets/images/hot_cappucino.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            10.h,

            ///Coffee Size Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Coffee Size',
                style: GoogleFonts.lato(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            20.h,

            ///Size Selector
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizeButton(
                  index: 0,
                  sizeButtonTitle: AppStr.sizeButtonTitleSmall,
                ),
                SizeButton(
                  index: 1,
                  sizeButtonTitle: AppStr.sizeButtonTitleMedium,
                ),
                SizeButton(
                  index: 2,
                  sizeButtonTitle: AppStr.sizeButtonTitleLarge,
                ),
              ],
            ),

            ///About the product
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 40, bottom: 20),
                  child: Text(
                    AppStr.aboutProduct,
                    style: GoogleFonts.lato(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 10),
                  child: SyrupDropdown(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                  'This is a hot cappuccino. It is made from the finest coffee beans and milk. It is a perfect drink for a cold day.',
                  style: GoogleFonts.lato(
                    color: AppColors.onSurface,
                    fontSize: 16,
                  )),
            ),

            ///Add to cart button
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 60),
              child: AddToCartButton(),
            ),
          ],
        ),
      ),
    );
  }
}
