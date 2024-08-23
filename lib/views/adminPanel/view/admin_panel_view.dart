import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/adminPanel/viewmodel/admin_panel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPanelView extends StatefulWidget {
  const AdminPanelView({super.key});

  @override
  State<AdminPanelView> createState() => _AdminPanelViewState();
}

class _AdminPanelViewState extends State<AdminPanelView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: FutureBuilder(
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
            return const Center(child: Text('Sipariş bulunamadı'));
          } else {
            final customerOrders = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: customerOrders.length,
              itemBuilder: (context, index) {
                final customerOrder = customerOrders[index];
                final orderItems =
                    customerOrder['order_items'] as List<dynamic>;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
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
                                      '${item['productName']} (${item['size']})',

                                      maxLines: 1, // Metin bir satırla sınırlı
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
