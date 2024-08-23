import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/services/auth/auth_gate.dart';
import 'package:coffee_shop/services/auth/auth_service.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/home/viewmodel/home_view_model.dart';
import 'package:coffee_shop/views/home/widget/bottom_nav_bar.dart';
import 'package:coffee_shop/views/home/widget/home_view_app_bar.dart';
import 'package:coffee_shop/views/profile/widget/my_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<Map<String, String?>> _fetchUserDetails() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      final nameFuture = authService.getUserName(userId);
      final surnameFuture = authService.getUserSurname(userId);

      final results = await Future.wait([nameFuture, surnameFuture]);
      return {
        'name': results[0],
        'surname': results[1],
      };
    }

    return {'name': null, 'surname': null};
  }

  /// Capitilize first letter of a string
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  void signOut() {
    try {
      ///Get auth service
      final AuthService authService =
          Provider.of<AuthService>(context, listen: false);

      ///Logout
      authService.signOut();

      ///Get home view models
      final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
      homeViewModel.setIndex(0);

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
                /// Circle Avatar
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
                FutureBuilder<Map<String, String?>>(
                  future: _fetchUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    final name = snapshot.data?['name'] ?? 'User';
                    final surname = snapshot.data?['surname'] ?? '';
                    final fullName =
                        '${capitalizeFirstLetter(name)} ${capitalizeFirstLetter(surname)}';
                    return Text(
                      fullName,
                      style: AppStyle.profileText,
                    );
                  },
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
          MyCard(title: 'Previous Orders', icon: Icons.history, onTap: () {}),
          MyCard(title: 'Settings', icon: Icons.settings, onTap: () {}),
          MyCard(title: 'About', icon: Icons.info, onTap: () {}),
          
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
