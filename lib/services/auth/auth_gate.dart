import 'package:coffee_shop/services/auth/login_or_register.dart';
import 'package:coffee_shop/views/home/widget/my_circular_progress_indicator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          ///User logged in
          if (snapshot.hasData) {
            return const Center(child: MyCircularProgressIndicator());  
          }
          /// user couldn't log in
          else {
            // return const LoginOrRegister();
            return const LoginOrRegister();
            
          }
        },
      ),
    );
  }
}
