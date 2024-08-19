
import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/cart/view/cart_view.dart';
import 'package:coffee_shop/views/home/view/home_view.dart';
import 'package:coffee_shop/views/home/viewmodel/home_view_model.dart';
import 'package:coffee_shop/views/orders/view/order_view.dart';
import 'package:coffee_shop/views/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.surface,
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          return Row(
            children: [
              _NavbarItem(
                homeRounded: Icons.home_rounded,
                data: 'Home',
                onTap: () {
                  homeViewModel.setIndex(0);
                  NavigationManager.instance
                      .navigateToPage(const HomeView());
                },
                isSelected: homeViewModel.currentIndex == 0,
              ),
              _NavbarItem(
                homeRounded: Icons.receipt_long,
                data: 'Orders',
                onTap: () {
                  homeViewModel.setIndex(1);
                  NavigationManager.instance
                      .navigateToPage(const OrderView());
                },
                isSelected: homeViewModel.currentIndex == 1,
              ),
              _NavbarItem(
                homeRounded: Icons.shopping_cart_rounded,
                data: 'Cart',
                onTap: () {
                  homeViewModel.setIndex(2);
                  NavigationManager.instance
                      .navigateToPage(const CartView());
                },
                isSelected: homeViewModel.currentIndex == 2,
              ),
              _NavbarItem(
                homeRounded: Icons.person,
                data: 'Profile',
                onTap: () {
                  homeViewModel.setIndex(3);
                  NavigationManager.instance
                      .navigateToPage(const ProfileView());
                },
                isSelected: homeViewModel.currentIndex == 3,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NavbarItem extends StatelessWidget {
  const _NavbarItem({
    required this.isSelected,
    required this.homeRounded,
    required this.data,
    required this.onTap,
  });

  final bool isSelected;
  final IconData homeRounded;
  final String data;
  final VoidCallback onTap;

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
            Icon(
              homeRounded,
              color: isSelected ? AppColors.primary : Colors.grey,
              size: 30,
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