import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/home/widget/bottom_nav_bar.dart';
import 'package:coffee_shop/views/home/widget/home_view_app_bar.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:coffee_shop/views/orders/widget/my_timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {

    final order = Provider.of<OrderViewModel>(context).orders;
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const HomeViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            const Divider(
              color: AppColors.onSecondary,
              thickness: 0.2,
            ),
            Text(
              'Order',
              style: AppStyle.titleTextStyle,
            ),

            /// Start of Timeline
            const MyTimelineTile(
              isFirst: true,
              isLast: false,
              isPast: true,
              eventCard: 'Order has been received.',
            ),

            /// Middle Timeline
            const MyTimelineTile(
              isFirst: false,
              isLast: false,
              isPast: true,
              eventCard: 'Order is prepearing.',
            ),

            /// End of Timeline
            const MyTimelineTile(
              isFirst: false,
              isLast: true,
              isPast: false,
              eventCard:
                  'Your order is completed !\nMeet us at the pickup area.',
            ),
            15.h,
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Order ID: 1234567890',
                    style: AppStyle.orderTextStyle,
                  ),
                  Text(
                    'Order Date: 12/12/2021',
                    style: AppStyle.orderTextStyle,
                  ),
                  Text(
                    'Order Time: 12:00 PM',
                    style: AppStyle.orderTextStyle,
                  ),
                ],
              ),
            ),

            /// Order ID
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
