// ignore_for_file: use_build_context_synchronously

import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/utils/app_dividers.dart';
import 'package:coffee_shop/utils/app_show_messages.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/adminPanel/viewmodel/admin_panel_view_model.dart';
import 'package:coffee_shop/views/adminPanel/viewmodel/card_view_model.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_shop/utils/app_colors.dart';

class OrderDetails extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final orderItems = order['order_items'] as List<dynamic>;
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final adminPanelViewModel = Provider.of<AdminPanelViewModel>(context);

    double total = orderItems.fold(
      0.0,
      (sum, item) =>
          sum + (item['price'] as double) * (item['quantity'] as int),
    );

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: AppColors.surface,
      ),
      body: Column(
        children: [
          AppDividers.homeViewDivider,
          Text(
            'Order ID: ${order['orderID']}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text('Date: ${order['orderDate']}'),
          Text('Time: ${order['orderTime']}'),
          Text('Status: ${order['orderStatus']}'),
          AppDividers.homeViewDivider,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height * 0.645,
            child: Consumer<OrderViewModel>(builder: (context, model, child) {
              return ListView(
                children: [
                  ...orderItems.asMap().entries.map((entry) {
                    var item = entry.value;
                    return ChangeNotifierProvider(
                      create: (_) => CardModel(),
                      child: Consumer<CardModel>(
                        builder: (context, model, child) {
                          return GestureDetector(
                            onTap: () {
                              model.toggleSelection();
                            },
                            child: Card(
                              color: model.isSelected
                                  ? AppColors.orderStatusGreen
                                  : AppColors.orderStatusRed,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${item['productName']}: ',
                                          style: AppStyle.orderDetailsProduct,
                                        ),
                                        Text('${item['size']}',
                                            style: AppStyle.orderDetailsText),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Syrup: ',
                                            style:
                                                AppStyle.orderDetailsProduct),
                                        Text(' ${item['syrup']}',
                                            style: AppStyle.orderDetailsText),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Quantity: ',
                                          style: AppStyle.orderDetailsProduct,
                                        ),
                                        Text(
                                            '${item['quantity']} x \$${item['price']}',
                                            style: AppStyle.orderDetailsText),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Total price
                Text('Total: \$${total.toStringAsFixed(2)}',
                    style: AppStyle.orderDetailsPrice),

                /// Complete order button
                GestureDetector(
                  onTap: () async {
                    try {
                      /// Order status to 'Completed'
                      await orderViewModel.updateOrderStatus(
                          order['orderID'], 'Completed');

                      /// Check if the order is completed
                      await orderViewModel.checkCompletedOrders();

                      /// Show success message and wait for the dialog to be closed
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 16,
                            backgroundColor: AppColors.surface,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      'Success',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.showSuccessDialogColor,
                                      ),
                                    ),
                                  ),
                                  AppDividers.showMessaseDialogDivider,
                                  15.h,
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Center(
                                      child: Text(
                                        'Order completed successfully.',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.surface,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color:
                                              AppColors.showSuccessDialogColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                            color: AppColors
                                                .showSuccessDialogColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      /// Fetch updated orders after the dialog is closed
                      await adminPanelViewModel.fetchOrders();
                      await adminPanelViewModel.fetchCompletedOrders();

                      /// Pop the current page
                      Navigator.of(context).pop();
                    } catch (e) {
                      /// Show error message
                      AppShowMessages.showErrorDialog(
                        context,
                        'An error occurred while completing the order',
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Complete Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
