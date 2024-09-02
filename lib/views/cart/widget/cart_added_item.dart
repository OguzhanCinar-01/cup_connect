import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/cart/widget/quantity_button.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartAddedItems extends StatelessWidget {
  const CartAddedItems({
    super.key,
    required this.orders,
  });

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);

    /// Added items Container
    return Container(
      width: double.infinity,
      height: 420,
      padding: const EdgeInsets.only(top: 25),
      child: ListView.separated(
        itemCount: orders.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.error,
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: AppColors.onPrimary),
            ),
            onDismissed: (direction) {
              orderViewModel.removeOrder(order);
            },
            child: Card(
              color: AppColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      order.productName,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Flavor
                        Text(
                          order.syrup,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        /// Size
                        Text(
                          order.size ?? 'No size',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        /// Price
                        Text(
                          '\$${order.price.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    /// Quantity Buttons
                    trailing: _quantityButtons(orderViewModel, order),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _quantityButtons(OrderViewModel orderViewModel, Order order) {
    return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Minus Button
                      QuantityButtons(
                        icon: Icons.remove,
                        onPressed: () =>
                            orderViewModel.decreaseQuantity(order),
                      ),

                      Text(order.quantity.toString(),
                          style: const TextStyle(fontSize: 15)),

                      /// Plus Button
                      QuantityButtons(
                          icon: Icons.add,
                          onPressed: () =>
                              orderViewModel.increaseQuantity(order)),
                    ],
                  );
  }
}
