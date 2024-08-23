import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/cart/widget/cart_added_item.dart';
import 'package:coffee_shop/views/cart/widget/order_now_button.dart';
import 'package:coffee_shop/views/home/widget/bottom_nav_bar.dart';
import 'package:coffee_shop/views/home/widget/home_view_app_bar.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final orders = orderViewModel.orders;
    final subtotal = orderViewModel.calculateSubTotal();
    final tax = orderViewModel.calculateTax();
    final total = orderViewModel.calculateTotal();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const HomeViewAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(
            color: AppColors.onSecondary,
            thickness: 0.2,
          ),
          /// Cart title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.w,
              Text(
                'Cart',
                style: AppStyle.titleTextStyle,
              ),
            ],
          ),

          /// Added items
          CartAddedItems(
            orders: orders,
          ),
          10.h,

          /// Subtotal
          Text('Subtotal: \$${subtotal.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              )),

          /// Tax
          Text('Tax: \$${tax.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              )),

          /// Divider
          const Divider(
            indent: 100,
            endIndent: 100,
            height: 10,
            color: AppColors.onSecondary,
            thickness: 0.2,
          ),

          /// Total
          Text(
            'Total: \$${total.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          /// Order Now button
          const OrderNowButton(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
