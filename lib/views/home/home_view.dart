import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/services/auth/auth_service.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/home/tabs/cold_coffee_tab.dart';
import 'package:coffee_shop/views/home/tabs/dessert_tab.dart';
import 'package:coffee_shop/views/home/tabs/hot_coffee_tab.dart';
import 'package:coffee_shop/views/home/widget/home_view_app_bar.dart';
import 'package:coffee_shop/views/home/widget/my_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

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
    final authService = Provider.of<AuthService>(context, listen: false);

    ///Logout
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
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
                ///Search bar
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
                  HotCoffeeTab(),
                  ColdCoffeeTab(),
                  DessertTab(),
                ],
              ),
            ),
            /// BottomNavigationBar
          ],
        ),
        bottomNavigationBar: GNav(
            backgroundColor: Colors.grey.shade300,
            color: Colors.black,
            activeColor: AppColors.secondary,
            tabBackgroundColor: AppColors.primary,
            gap: 8,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.maps_ugc_outlined,
                text: 'Orders',
              ),
              GButton(
                icon: Icons.shopping_cart_outlined,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ]),
      ),
    );
  }
}
