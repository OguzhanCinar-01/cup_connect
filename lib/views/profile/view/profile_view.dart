import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/services/auth/auth_gate.dart';
import 'package:coffee_shop/services/auth/auth_service.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/home/viewmodel/home_view_model.dart';
import 'package:coffee_shop/views/home/widget/bottom_nav_bar.dart';
import 'package:coffee_shop/views/home/widget/home_view_app_bar.dart';
import 'package:coffee_shop/views/profile/view/about_view.dart';
import 'package:coffee_shop/views/profile/view/previous_orders_view.dart';
import 'package:coffee_shop/views/profile/viewmodel/profile_view_model.dart';
import 'package:coffee_shop/views/profile/widget/my_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).loadUserData();
  }

  void signOut() {
    try {
      final AuthService authService =
          Provider.of<AuthService>(context, listen: false);
      authService.signOut();

      final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
      homeViewModel.setIndex(0);

      NavigationManager.instance.navigateToPageClear(const AuthGate());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

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
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.09,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.onPrimary,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                20.w,

                /// Profile User Text
                if (profileViewModel.isLoading)
                  const CircularProgressIndicator()
                else
                  Text(
                    '${profileViewModel.userName} ${profileViewModel.userSurname}',
                    style: AppStyle.profileText,
                  ),
                const Spacer(),

                /// Logout Button
                GestureDetector(
                  onTap: signOut,
                  child: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          10.h,
          MyCard(
              title: 'Previous Orders',
              icon: Icons.history,
              onTap: () {
                NavigationManager.instance
                    .navigateToPage(const PreviousOrdersView());
              }),
          MyCard(title: 'Settings', icon: Icons.settings, onTap: () {}),
          MyCard(
              title: 'About',
              icon: Icons.info,
              onTap: () {
                NavigationManager.instance.navigateToPage(const AboutView());
              }),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
