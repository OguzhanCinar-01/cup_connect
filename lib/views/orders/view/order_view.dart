import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/adminPanel/viewmodel/admin_panel_view_model.dart';
import 'package:coffee_shop/views/cart/widget/order_now_button.dart';
import 'package:coffee_shop/views/home/widget/bottom_nav_bar.dart';
import 'package:coffee_shop/views/home/widget/home_view_app_bar.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:coffee_shop/views/orders/widget/my_timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when the widget is initialized
    final adminPanelViewModel =
        Provider.of<AdminPanelViewModel>(context, listen: false);

    // Get the current user's ID
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      adminPanelViewModel.fetchOrdersById(userId);
      print('Order Fetched');
    } else {
      print('User not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    final adminPanelViewModel = Provider.of<AdminPanelViewModel>(context);
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final orders = adminPanelViewModel.orders;

    void completeOrder() async {
      if (orders.isNotEmpty) {
        final updatedOrder =
            await orderViewModel.getOrderById(orders.first['orderID']);
        final orderStatus = orders.first['orderStatus'];

        /// If order is found, update the order status to 'Completed'
        if (updatedOrder != null && orderStatus == 'Completed') {
          // Add the order to the completedOrders collection
          await orderViewModel.completedOrders(
              orders.first['orderID'], updatedOrder);

          // Delete the order from the orders collection
          await orderViewModel.deleteOrder(orders.first['orderID']);

          // Fetch the updated orders
          final userId = FirebaseAuth.instance.currentUser?.uid;
          if (userId != null) {
            await adminPanelViewModel.fetchOrdersById(userId);
            print('completedORder data fetched');
            await orderViewModel.checkCompletedOrders();
            print('completedOrders: ${orderViewModel.completedOrders}');
          }

          // Notify the user that the order has been completed
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Enjoy your coffee!'),
            ),
          );
        }
      }
    }

    final orderStatus =
        orders.isNotEmpty ? orders.first['orderStatus'] : 'Pending';

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const HomeViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(
              color: AppColors.onSecondary,
              thickness: 0.2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Status',
                  style: AppStyle.titleTextStyle,
                ),
              ],
            ),
            if (orders.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'No orders found',
                    style: AppStyle.titleTextStyle,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView(
                  shrinkWrap: false,
                  children: [
                    MyTimelineTile(
                      isFirst: true,
                      isLast: false,
                      isPast: orderStatus == 'Preparing' ||
                          orderStatus == 'Pending' ||
                          orderStatus == 'Completed',
                      eventCard:
                          adminPanelViewModel.getTimelineStatus('Pending'),
                    ),
                    MyTimelineTile(
                      isFirst: false,
                      isLast: false,
                      isPast: orderStatus == 'Preparing' ||
                          orderStatus == 'Completed',
                      eventCard:
                          adminPanelViewModel.getTimelineStatus('Preparing'),
                    ),
                    MyTimelineTile(
                      isFirst: false,
                      isLast: true,
                      isPast: orderStatus == 'Completed',
                      eventCard:
                          adminPanelViewModel.getTimelineStatus('Completed'),
                    ),
                  ],
                ),
              ),

            const Divider(
              color: AppColors.onSecondary,
              thickness: 0.2,
            ),

            /// Order details
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Order ID:  ', style: AppStyle.priceTextStyle),
                  Text(orders.isNotEmpty ? orders.first['orderID'] : '',
                      style: AppStyle.priceTextStyleBold),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Date:  ', style: AppStyle.priceTextStyle),
                  Text(orders.isNotEmpty ? orders.first['orderDate'] : '',
                      style: AppStyle.priceTextStyleBold),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Time:  ', style: AppStyle.priceTextStyle),
                  Text(orders.isNotEmpty ? orders.first['orderTime'] : '',
                      style: AppStyle.priceTextStyleBold),
                ],
              ),
            ),

            /// Complete Order button
            MyButton(
              onTap: completeOrder,
              title: 'Complete Order',
              color: orderStatus == 'Completed'
                  ? AppColors.primary
                  : AppColors.completeOrderButtonColor,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
