import 'package:coffee_shop/services/auth/auth_service.dart';
import 'package:coffee_shop/services/auth/login_or_register.dart';
import 'package:coffee_shop/views/home/widget/my_circular_progress_indicator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: MyCircularProgressIndicator());
          }

          ///User logged in
          if (snapshot.hasData) {
            final user = snapshot.data!;
            Future.microtask(() => authService.handleRedirect(user));
            return const Center(child: MyCircularProgressIndicator());
          }

          /// user couldn't log in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
