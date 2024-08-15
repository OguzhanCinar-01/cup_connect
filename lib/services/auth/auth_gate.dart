import '../../views/home/view/home_view.dart';
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
            return const HomeView();
          }

          /// user couldn't log in
          else {
            return const HomeView();
            // return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
