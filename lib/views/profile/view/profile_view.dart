import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/home/widget/bottom_nav_bar.dart';
import 'package:coffee_shop/views/home/widget/home_view_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const HomeViewAppBar(),
      body: Column(
        children: [
          const Divider(
            color: AppColors.onSecondary,
            thickness: 0.2,
          ),
          Row(
            children: [
              35.w,
              Text(
                'Profile',
                style: AppStyle.titleTextStyle,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
