import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_dividers.dart';
import 'package:coffee_shop/utils/app_show_messages.dart';
import 'package:coffee_shop/utils/app_strings.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:coffee_shop/views/product/viewmodel/product_view_model.dart';
import 'package:coffee_shop/views/product/widget/go_back_button.dart';
import 'package:coffee_shop/views/product/widget/size_button.dart';
import 'package:coffee_shop/views/product/widget/syrup_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    super.key,
  });

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductViewModel>(context).selectedProduct;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Product Selected'),
        ),
        body: const Center(
          child: Text('No product selected.'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Go back button
            const GoBackButton(),

            /// Product image
            _productImage(context, product),
            10.h,

            /// Product name
            _productName(context, product),

            ///Syrup dropdown
            if (product.coffeeSize.isNotEmpty) _syrupDropdown(),

            ///Size Selector
            if (product.coffeeSize.isNotEmpty) _sizeSelector(),
            AppDividers.productViewDivider,

            ///About the product
            _aboutProduct(),
            5.h,

            ///Product description
            _productDescription(context, product),
            const Spacer(),

            ///Add to cart button
            _addToCartButton(product),
          ],
        ),
      ),
    );
  }

  Widget _syrupDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 40, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Add Syrup (optional) : ',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
          const Spacer(),
          SyrupDropdown(),
        ],
      ),
    );
  }

  Widget _productImage(BuildContext context, Product product) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: AppColors.surface,
          image: DecorationImage(
            image: AssetImage(product.imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _productName(BuildContext context, Product product) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 100)
          : const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        product.name,
        style: AppStyle.productTitle,
        maxLines: 2,
      ),
    );
  }

  Widget _sizeSelector() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizeButton(
            index: 0,
            sizeButtonTitle: AppStr.sizeButtonTitleSmall,
            onPressed: () {
              Provider.of<ProductViewModel>(context, listen: false)
                  .updateProductSize(AppStr.sizeButtonTitleSmall);
            },
          ),
          SizeButton(
            index: 1,
            sizeButtonTitle: AppStr.sizeButtonTitleMedium,
            onPressed: () {
              Provider.of<ProductViewModel>(context, listen: false)
                  .updateProductSize(AppStr.sizeButtonTitleMedium);
            },
          ),
          SizeButton(
            index: 2,
            sizeButtonTitle: AppStr.sizeButtonTitleLarge,
            onPressed: () {
              Provider.of<ProductViewModel>(context, listen: false)
                  .updateProductSize(AppStr.sizeButtonTitleLarge);
            },
          ),
        ],
      ),
    );
  }

  Widget _productDescription(BuildContext context, Product product) {
    return Padding(
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 100)
          : const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        product.description,
        style: AppStyle.description,
        maxLines: 7,
      ),
    );
  }

  Widget _aboutProduct() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        AppStr.aboutProduct,
        style: AppStyle.orderTextStyle,
      ),
    );
  }

  Widget _addToCartButton(Product product) {
    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 80),
      child: GestureDetector(
        onTap: () {
          /// Add items to orders screen
          final order = Order(
            productName: product.name,
            price: product.price,
            size: product.coffeeSize,
            syrup: product.syrup,
          );
          AppShowMessages.showSuccessDialog(
            context,
            'Item added to cart.',
          );

          Provider.of<OrderViewModel>(context, listen: false).addOrder(order);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.center,
          width: 300,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            /// Product price will be added here
            'Add to Cart  |   \$ ${product.price.toStringAsFixed(2)}',
            style: GoogleFonts.lato(
              color: AppColors.surface,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
