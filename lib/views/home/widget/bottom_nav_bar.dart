import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/cart/view/cart_view.dart';
import 'package:coffee_shop/views/home/view/home_view.dart';
import 'package:coffee_shop/views/home/viewmodel/home_view_model.dart';
import 'package:coffee_shop/views/orders/view/order_view.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:coffee_shop/views/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderViewModel>(context, listen: false)
          .checkCompletedOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Consumer<OrderViewModel>(
      builder: (context, orderViewModel, child) {
        final cartItemCount = orderViewModel.orders.length;
        final hasCompletedOrders = orderViewModel.hasCompletedOrders;
        print('Has Completed Orders: $hasCompletedOrders');

        return Container(
          height: 100,
          color: AppColors.surface,
          child: Row(
            children: [
              _NavbarItem(
                homeRounded: Icons.home_rounded,
                data: 'Home',
                onTap: () {
                  homeViewModel.setIndex(0);
                  NavigationManager.instance
                      .navigateToPageClear(const HomeView());
                },
                isSelected: homeViewModel.currentIndex == 0,
              ),
              _NavbarItem(
                homeRounded: Icons.receipt_long,
                data: 'Orders',
                onTap: () {
                  homeViewModel.setIndex(1);
                  NavigationManager.instance
                      .navigateToPageClear(const OrderView());
                },
                isSelected: homeViewModel.currentIndex == 1,
                isCompleted: hasCompletedOrders,
                
              ),
              _NavbarItem(
                homeRounded: Icons.shopping_cart_rounded,
                data: 'Cart',
                onTap: () {
                  homeViewModel.setIndex(2);
                  NavigationManager.instance
                      .navigateToPageClear(const CartView());
                },
                isSelected: homeViewModel.currentIndex == 2,
                cartItemCount: cartItemCount,
              ),
              _NavbarItem(
                homeRounded: Icons.person,
                data: 'Profile',
                onTap: () {
                  homeViewModel.setIndex(3);
                  NavigationManager.instance
                      .navigateToPageClear(const ProfileView());
                },
                isSelected: homeViewModel.currentIndex == 3,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavbarItem extends StatelessWidget {
  const _NavbarItem({
    required this.isSelected,
    required this.homeRounded,
    required this.data,
    required this.onTap,
    this.cartItemCount = 0,
    this.isCompleted = false,
  });

  final bool isSelected;
  final IconData homeRounded;
  final String data;
  final VoidCallback onTap;
  final int cartItemCount;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            15.h,
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  homeRounded,
                  color: isSelected ? AppColors.primary : Colors.grey,
                  size: 30,
                ),
                if (cartItemCount > 0)
                  Positioned(
                    right: -10,
                    top: -13,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Center(
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (isCompleted)
                  Positioned(
                    right: -13,
                    top: -13,
                    child: Icon(
                      Icons.error,
                      color: AppColors.error,
                      size: 20,
                    ),
                  ),
              ],
            ),
            Text(
              data,
              style: GoogleFonts.poppins(
                color: isSelected ? AppColors.primary : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
