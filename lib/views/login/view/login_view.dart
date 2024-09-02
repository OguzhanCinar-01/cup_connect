// ignore_for_file: use_build_context_synchronously

import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/views/adminPanel/view/admin_panel_view.dart';
import 'package:coffee_shop/views/home/view/home_view.dart';

import '../../../extensions/space_exs.dart';
import '../../../services/auth/auth_service.dart';
import 'package:provider/provider.dart';
import '../../../utils/cupconnect_logo.dart';
import '../widget/my_button.dart';
import '../widget/my_textfield.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class LoginView extends StatefulWidget {
  final void Function()? onTap;
  const LoginView({super.key, required this.onTap});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// sign in user
  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  /// sign in as guest
  void signInAsGuest() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInAnonymously();

      // After sign in, navigate to home page
      NavigationManager.instance.navigateToPageClear(const HomeView());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  /// sign in as admin
  void signInAsAdmin() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      // Admin validation before sign in
      if (!_isAdmin(emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Admin invalid!'),
          ),
        );
        return; // Return to prevent further execution if not admin
      }

      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );

      // Navigate to Admin Panel after successful sign in
      NavigationManager.instance.navigateToPageClear(const AdminPanelView());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  bool _isAdmin(String email) {
    const adminEmails = ['admin@gmail.com'];
    return adminEmails.contains(email);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.h,
                  const CupConnectLogo(),
                  10.h,

                  /// Title
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  15.h,

                  /// Email Textfield
                  MyTextField(
                    controller: emailController,
                    hint: 'Email',
                    isPassword: false,
                  ),
                  10.h,

                  /// Password Textfield
                  MyTextField(
                    controller: passwordController,
                    hint: 'Password',
                    isPassword: true,
                  ),
                  20.h,

                  /// Login Button
                  MyButton(
                    title: 'Login',
                    onTap: signIn,
                  ),
                  15.h,

                  /// Admin Login Button
                  MyButton(
                    title: 'Admin Girişi',
                    onTap: signInAsAdmin,
                  ),
                  15.h,

                  /// Guest Login Button
                  /*MyButton(
                    title: 'Guest Girişi',
                    onTap: signInAsGuest,
                  ),*/
                  15.h,

                  /// Register Line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      8.w,
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
