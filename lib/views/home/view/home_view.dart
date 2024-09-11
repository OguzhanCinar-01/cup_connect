// ignore_for_file: unused_local_variable

import 'package:coffee_shop/utils/app_dividers.dart';
import 'package:coffee_shop/utils/app_strings.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/views/home/viewmodel/load_user_view_model.dart';
import 'package:coffee_shop/views/home/viewmodel/product_data_view_model.dart';
import 'package:coffee_shop/views/home/viewmodel/search_view_model.dart';
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
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    String? userId = FirebaseAuth.instance.currentUser!.uid;
    _searchController.addListener(onSearchChanged);
    Provider.of<LoadUserViewModel>(context, listen: false).loadUserData(userId);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchController.removeListener(onSearchChanged);
    super.dispose();
  }

  void onSearchChanged() {
    Provider.of<SearchViewModel>(context, listen: false).searchQuery =
        _searchController.text;
  }

  String getUserTextMessage() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 12) {
      return AppStr.goodMorning;
    } else if (hour >= 12 && hour < 18) {
      return AppStr.goodAfternoon;
    } else {
      return AppStr.goodEvening;
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
    final loadUserViewModel = Provider.of<LoadUserViewModel>(context);
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: const HomeViewAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDividers.homeViewDivider,

              /// Good morning text
              loadUserViewModel.isLoading
                  ? const Center(child: MyCircularProgressIndicator())
                  : _greetingText(loadUserViewModel.userName),

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
        ),

        /// BottomNavigationBar
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }

  Widget _greetingText(String name) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, left: 35),
      child: Text(
        '${getUserTextMessage()}, $name',
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
        focusNode: _focusNode,
        controller: _searchController,
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
