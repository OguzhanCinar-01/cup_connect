import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/views/cart/view/cart_view.dart';
import 'package:coffee_shop/views/home/view/home_view.dart';
import 'package:coffee_shop/views/orders/view/order_view.dart';
import 'package:coffee_shop/views/product/view/product_view.dart';
import 'package:coffee_shop/views/profile/view/profile_view.dart';
import 'services/auth/auth_gate.dart';
import 'services/auth/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifier/provider_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ...ProviderManager.instance.providers,
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: NavigationManager.instance.navigatorKey,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const AuthGate(),
        /// Add routes
        /* 
        routes: {
          '/authGate': (context) => const AuthGate(),
          '/home': (context) => const HomeView(),
          '/profile': (context) => const ProfileView(),
          '/cart': (context) => const CartView(),
          '/order': (context) => const OrderView(),
          '/productView': (context) => const ProductView(),
        }*/
        );
  }
}
