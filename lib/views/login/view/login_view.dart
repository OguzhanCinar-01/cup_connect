import 'package:coffee_shop/utils/app_dividers.dart';

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

  /// sign in user or admin
  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primarySurface,
                  AppColors.primary,
                  AppColors.primarySurface,
                ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    50.h,
                    const CupConnectLogo(),
                    50.h,

                    /// Title
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppDividers.loginDivider,
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

                    /// Register Line
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: AppColors.onPrimary,
                            fontSize: 15,
                          ),
                        ),
                        8.w,
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: AppColors.onSecondary,
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
      ),
    );
  }
}
