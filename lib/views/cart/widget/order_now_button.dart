import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_strings.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderNowButton extends StatelessWidget {
  const OrderNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        /// Add items to database
        final OrderViewModel orderViewModel =
            Provider.of<OrderViewModel>(context, listen: false);

        if (orderViewModel.orders.isNotEmpty) {
          await orderViewModel.submitOrder();
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content: const Text('Your order has been placed successfully!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        } else {
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Your should add items to cart first!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        width: 250,
        height: 65,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary,
        ),
        child: Center(
          child: Text(
            AppStr.orderNow,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
