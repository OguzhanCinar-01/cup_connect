import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/utils/app_colors.dart';
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
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
                _buildOrdersTab(context),
                _buildCompletedTab(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AdminPanelViewModel>(context).getAdminPanelData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('An error occurred!'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No orders found.'));
        } else {
          final customerOrders = snapshot.data as List<Map<String, dynamic>>;
          return ListView.builder(
            itemCount: customerOrders.length,
            itemBuilder: (context, index) {
              final customerOrder = customerOrders[index];
              final orderItems = customerOrder['order_items'] as List<dynamic>;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    // Order details
                    NavigationManager.instance.navigateToPage(OrderDetails(
                      order: customerOrder,
                    ));
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

                          /// Divider
                          const Divider(color: Colors.white),
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

  Widget _buildCompletedTab(BuildContext context) {
    // Completed tab için benzer FutureBuilder eklenebilir.
    return const Center(child: Text('Completed orders will be shown here.'));
  }
}
