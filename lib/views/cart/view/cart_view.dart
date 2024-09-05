// ignore_for_file: use_build_context_synchronously

import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_dividers.dart';
import 'package:coffee_shop/utils/app_show_messages.dart';
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

/// Add orders to the database

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    void addToOrders() async {
      /// Add items to database
      final OrderViewModel orderViewModel =
          Provider.of<OrderViewModel>(context, listen: false);

      bool canPlaceOrder = await orderViewModel.canPlaceNewOrder();

      if (canPlaceOrder) {
        if (orderViewModel.orders.isNotEmpty) {
          await orderViewModel.submitOrder();
          AppShowMessages.showSuccessDialog(
            context,
            'Order placed successfully.',
          );
        } else {
          AppShowMessages.showErrorDialog(
            context,
            'You have no items in your cart.',
          );
        }
      } else {
        AppShowMessages.showErrorDialog(
          context,
          'You have an active order. Please wait for it to be completed.',
        );
      }
    }

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
          AppDividers.homeViewDivider,

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
          AppDividers.cartViewDivider,

          /// Total
          Text(
            'Total: \$${total.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          /// Order Now button
          MyButton(
            onTap: addToOrders,
            title: 'Order Now',
            color: AppColors.primary,
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
