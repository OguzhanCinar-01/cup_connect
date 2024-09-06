import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_dividers.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/utils/cupconnect_logo.dart';
import 'package:coffee_shop/views/adminPanel/viewmodel/admin_panel_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviousOrdersView extends StatefulWidget {
  const PreviousOrdersView({super.key});

  @override
  State<PreviousOrdersView> createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrdersView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      Provider.of<AdminPanelViewModel>(context, listen: false)
          .fetchCompletedOrdersbyUserID(userId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final adminPanelViewModel = Provider.of<AdminPanelViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        toolbarHeight: 70,
        title: const CupConnectLogo(
          fontSize: 30,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            AppDividers.homeViewDivider,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              alignment: Alignment.topLeft,
              child:  Text(
                'Previous Orders',
                style: AppStyle.titleTextStyle,
              ),
            ),
            AppDividers.previousOrdersDivider,
            Expanded(
              child: adminPanelViewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : adminPanelViewModel.completedOrders.isEmpty
                      ? const Center(child: Text('No previous orders'))
                      : ListView.builder(
                          itemCount: adminPanelViewModel.completedOrders.length,
                          itemBuilder: (context, index) {
                            final order = adminPanelViewModel.completedOrders[index];
                            final orderItems = order['order_items'] as List<dynamic>;
                            return Card(
                              color: AppColors.secondary,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order ID: ${order['orderID']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('Date: ${order['orderDate']}'),
                                    Text('Time: ${order['orderTime']}'),
                                    Text('Status: ${order['orderStatus']}'),
                                    AppDividers.orderCardDivider,
                                    ...orderItems.map((item) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                '${item['productName']}:  ${item['size']}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text('Syrup: ${item['syrup']}'),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
