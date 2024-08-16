import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/services/auth/login_or_register.dart';

import '../../../extensions/space_exs.dart';
import '../../../services/auth/auth_service.dart';
import '../../../utils/app_colors.dart';
import '../viewmodel/home_view_model.dart';
import '../widget/home_view_app_bar.dart';
import '../widget/my_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widget/coffee_grid_item.dart';

part 'cold_coffee_tab.dart';
part 'dessert_tab.dart';
part 'hot_coffee_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key,});


  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> myTabs = [
    const MyTab(
      iconPath: 'assets/images/hot_coffee.png',
      title: 'Hot Coffee',
    ),
    const MyTab(
      iconPath: 'assets/images/cold_coffee.png',
      title: 'Cold Coffee',
    ),
    const MyTab(iconPath: 'assets/images/dessert.png', title: 'Dessert'),
  ];
  void signOut() {
    ///get auth service
    final AuthService authService = Provider.of<AuthService>(context, listen: false);
    ///Logout
    authService.signOut();
    
  }

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
            ///logout button
            IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
            const Divider(
              color: Colors.black,
              thickness: 0.2,
            ),

            /// Good morning text
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20, left: 35),
              child: Text(
                'Good morning, User',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                ),
              ),
            ),
            20.h,

            /// Search bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.black,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.black),
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
            ),
            10.h,

            /// TabBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _HotCoffeeTab(),
                  ColdCoffeeTab(),
                  DessertTab(),
                ],
              ),
            ),

            /// BottomNavigationBar
          ],
        ),
        bottomNavigationBar: Container(
          height: 100,
          color: AppColors.surface,
          child: Consumer<HomeViewModel>(
            builder: (context, homeViewModel, child) {
              return Row(
                children: [
                  _NavbarItem(
                    homeRounded: Icons.home_rounded,
                    data: 'Home',
                    onTap: () => homeViewModel.setIndex(0),
                    isSelected: homeViewModel.currentIndex == 0,
                  ),
                  _NavbarItem(
                    homeRounded: Icons.receipt_long,
                    data: 'Orders',
                    onTap: () => homeViewModel.setIndex(1),
                    isSelected: homeViewModel.currentIndex == 1,
                  ),
                  _NavbarItem(
                    homeRounded: Icons.shopping_cart_rounded,
                    data: 'Cart',
                    onTap: () => homeViewModel.setIndex(2),
                    isSelected: homeViewModel.currentIndex == 2,
                  ),
                  _NavbarItem(
                    homeRounded: Icons.person,
                    data: 'Profile',
                    onTap: () => homeViewModel.setIndex(3),
                    isSelected: homeViewModel.currentIndex == 3,
                  ),
                ],
              );
            },
          ),
        ),
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
