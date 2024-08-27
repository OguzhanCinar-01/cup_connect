import 'package:coffee_shop/services/firebase_service.dart';
import 'package:coffee_shop/utils/app_strings.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/home/widget/bottom_nav_bar.dart';
import 'package:coffee_shop/views/home/widget/my_circular_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../extensions/space_exs.dart';
import '../../../utils/app_colors.dart';
import '../widget/home_view_app_bar.dart';
import '../widget/my_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/coffee_grid_item.dart';

part 'cold_coffee_tab.dart';
part 'dessert_tab.dart';
part 'hot_coffee_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<String?> _userNameFuture;
  String _userName = '';
  bool _isloading = true;

  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    String? userId = FirebaseAuth.instance.currentUser!.uid;
    _userNameFuture = _firebaseService.getUserName(userId);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      String? userName = await _userNameFuture;
      setState(() {
        _userName = userName ?? 'User';
        _userName = _userName[0].toUpperCase() + _userName.substring(1);
        _isloading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isloading = false;
      });
    }
  }

  List<Widget> myTabs = [
    const MyTab(
      iconPath: 'assets/images/hot_coffee.png',
      title: 'Hot Coffee',
    ),
    const MyTab(
      iconPath: 'assets/images/cold_coffee.png',
      title: 'Cold Coffee',
    ),
    const MyTab(
      iconPath: 'assets/images/dessert.png',
      title: 'Dessert',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: const HomeViewAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.black,
              thickness: 0.2,
            ),

            /// Good morning text
            _isloading
                ? const Center(child: MyCircularProgressIndicator())
                : _goodMorningText(_userName),

            20.h,

            /// Search bar
            _searchBar(context),
            10.h,

            /// TabBar
            _tabBar(context),

            /// TabBarView
            _tabBarView(),
          ],
        ),

        /// BottomNavigationBar
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }

  Widget _goodMorningText(String name) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, left: 35),
      child: Text(
        '${AppStr.goodMorning}, $name',
        style: AppStyle.titleTextStyle,
      ),
    );
  }

  Widget _tabBarView() {
    return const Expanded(
      child: TabBarView(
        children: [
          _HotCoffeeTab(),
          ColdCoffeeTab(),
          DessertTab(),
        ],
      ),
    );
  }

  Widget _tabBar(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 100)
          : const EdgeInsets.symmetric(horizontal: 15),
      child: TabBar(
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 4,
          ),
        ),
        labelColor: AppColors.primary,
        indicatorWeight: 3,
        tabs: myTabs,
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 100)
          : const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppStr.searchHintText,
          hintStyle: AppStyle.orderTextStyle,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: AppColors.onSecondary, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade100,
            ),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}


// Depricated Feature

// class _OldNavBar extends StatelessWidget {
//   const _OldNavBar();

//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: GNav(
//           backgroundColor: AppColors.surface,
//           color: Colors.black,
//           activeColor: AppColors.onPrimary,
//           tabBackgroundColor: AppColors.primary,
//           gap: 8,
//           padding: EdgeInsets.all(16),
//           tabs: [
//             GButton(
//               icon: Icons.home,
//               text: 'Home',
//               textColor: AppColors.onPrimary,
//               iconActiveColor: AppColors.onPrimary,
//             ),
//             GButton(
//               icon: Icons.maps_ugc_outlined,
//               text: 'Orders',
//               textColor: AppColors.onPrimary,
//             ),
//             GButton(
//               icon: Icons.shopping_cart_outlined,
//               text: 'Cart',
//               textColor: AppColors.onPrimary,
//             ),
//             GButton(
//               icon: Icons.person,
//               text: 'Profile',
//               textColor: AppColors.onPrimary,
//             ),
//           ]),
//     );
//   }
// }
