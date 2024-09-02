import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/services/auth/auth_gate.dart';
import 'package:coffee_shop/services/auth/auth_service.dart';
import 'package:coffee_shop/services/firebase_service.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/home/viewmodel/home_view_model.dart';
import 'package:coffee_shop/views/home/widget/bottom_nav_bar.dart';
import 'package:coffee_shop/views/home/widget/home_view_app_bar.dart';
import 'package:coffee_shop/views/profile/view/about_view.dart';
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
  /// Getting user data from Firebase
  final FirebaseService _firebaseService = FirebaseService();
  String _userName = 'User';
  String _userSurname = '';
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        String? userName = await _firebaseService.getUserName(userId);
        String? userSurname = await _firebaseService.getUserSurname(userId);

        setState(() {
          _userName = userName != null && userName.isNotEmpty
              ? userName[0].toUpperCase() + userName.substring(1)
              : 'User';

          _userSurname = userSurname.isNotEmpty
              ? userSurname[0].toUpperCase() + userSurname.substring(1)
              : '';
          _isloading = false;
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        _isloading = false;
      });
    }
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
                if (_isloading)
                  const CircularProgressIndicator()
                else
                  Text(
                    '$_userName $_userSurname',
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
          MyCard(title: 'Previous Orders', icon: Icons.history, onTap: () {}),
          MyCard(title: 'Settings', icon: Icons.settings, onTap: () {}),
          MyCard(
              title: 'About',
              icon: Icons.info,
              onTap: () {
                NavigationManager.instance.navigateToPage(const AboutView());
                print('About clicked');
              }),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
