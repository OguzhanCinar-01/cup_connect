import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/services/auth/auth_gate.dart';
import 'package:coffee_shop/services/auth/auth_service.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_dividers.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/utils/cupconnect_logo.dart';
import 'package:coffee_shop/views/adminPanel/view/order_details.dart';
import 'package:coffee_shop/views/adminPanel/viewmodel/admin_panel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPanelView extends StatefulWidget {
  const AdminPanelView({super.key});

  @override
  State<AdminPanelView> createState() => _AdminPanelViewState();
}

class _AdminPanelViewState extends State<AdminPanelView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final adminPanelViewModel =
        Provider.of<AdminPanelViewModel>(context, listen: false);

    adminPanelViewModel.fetchOrders();
    adminPanelViewModel.fetchCompletedOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void signOut() {
    try {
      ///Get auth service
      final AuthService authService =
          Provider.of<AuthService>(context, listen: false);

      ///Logout
      authService.signOut();

      ///Navigate to AuthGate
      NavigationManager.instance.navigateToPageClear(const AuthGate());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      ///AppBar
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 115),
            child: CupConnectLogo(
              fontSize: 30,
              color: AppColors.onSecondary,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      ///Body
      body: Column(
        children: [
          /// TabBar
          Padding(
            padding: MediaQuery.of(context).size.width > 600
                ? const EdgeInsets.symmetric(horizontal: 100)
                : const EdgeInsets.symmetric(horizontal: 15),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Orders'),
                Tab(text: 'Completed Orders'),
              ],
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
            ),
          ),

          /// TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersTab(),
                _buildCompletedOrdersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return Consumer<AdminPanelViewModel>(
      builder: (context, viewModel, child) {
        /// Check if orders are completed
        final isCompleted = viewModel.orders
            .every((order) => order['orderStatus'] == 'Completed');

        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.orders.isEmpty || isCompleted) {
          return const Center(child: Text('No orders found.'));
        } else {
          /// Display orders
          final pendingOrders = viewModel.orders
              .where((order) => order['orderStatus'] != 'Completed')
              .toList();

          return ListView.builder(
            itemCount: pendingOrders.length,
            itemBuilder: (context, index) {
              final customerOrder = pendingOrders[index];
              final orderItems = customerOrder['order_items'] as List<dynamic>;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await viewModel.setUpdateOrderStatus(
                          customerOrder['orderID'], 'Preparing');
                      final updatedOrder = await viewModel
                          .getOrderById(customerOrder['orderID']);
                      if (updatedOrder != null) {
                        NavigationManager.instance.navigateToPage(
                          OrderDetails(order: updatedOrder),
                        );
                      }
                    } catch (e) {
                      print('Error updating order status: $e');
                    }
                  },
                  child: Card(
                    color: AppColors.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order ID: ${customerOrder['orderID']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text('Date: ${customerOrder['orderDate']}'),
                          Text('Time: ${customerOrder['orderTime']}'),
                          Text('Status: ${customerOrder['orderStatus']}'),
                          AppDividers.orderCardDivider,
                          ...orderItems.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                              ),
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
                                  Text(
                                      ' ${item['quantity']} x \$${item['price']} '),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildCompletedOrdersTab() {
    return Consumer<AdminPanelViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.completedOrders.isEmpty) {
          return const Center(child: Text('No completed orders found.'));
        } else {
          // Add completed orders to the list of orders
          final completedOrders = [
            ...viewModel.orders
                .where((order) => order['orderStatus'] == 'Completed'),
            ...viewModel.completedOrders,
          ];

          double totalPrice = 0;
          for (var order in completedOrders) {
            final orderItems = order['order_items'] as List<dynamic>;
            for (var item in orderItems) {
              totalPrice += item['price'] * item['quantity'];
            }
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: completedOrders.length,
                  itemBuilder: (context, index) {
                    final orderData = completedOrders[index];
                    final orderItems =
                        orderData['order_items'] as List<dynamic>;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Card(
                        color: AppColors.secondary,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order ID: ${orderData['orderID']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text('Date: ${orderData['orderDate']}'),
                              Text('Time: ${orderData['orderTime']}'),
                              Text('Status: ${orderData['orderStatus']}'),
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
                      ),
                    );
                  },
                ),
              ),
              AppDividers.showMessaseDialogDivider,
              Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 10),
                child: Row(
                  children: [
                    Text('Total Orders: ${completedOrders.length}',
                        style: AppStyle.orderDetailsPrice),
                    const Spacer(),
                    Text('Total: \$${totalPrice.toStringAsFixed(2)}',
                        style: AppStyle.orderDetailsPrice),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
