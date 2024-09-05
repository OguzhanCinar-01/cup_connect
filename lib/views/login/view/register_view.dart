import 'package:coffee_shop/services/firebase_service.dart';
import 'package:coffee_shop/utils/app_dividers.dart';

import '../../../extensions/space_exs.dart';
import '../../../services/auth/auth_service.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/cupconnect_logo.dart';
import '../widget/my_button.dart';
import '../widget/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  final void Function()? onTap;
  const RegisterView({super.key, required this.onTap});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();

  /// Sign Up Function
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Passwords do not match!'),
              ));
      return;
    }

    /// get authservice
    final authService = Provider.of<AuthService>(context, listen: false);
    final firebaseService =
        Provider.of<FirebaseService>(context, listen: false);
    try {
      final userCredential = await authService.signUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );

      /// if the user is successfully created, create a new document in the users collection
      if (userCredential.user != null) {
        await firebaseService.addUserDetails(
          nameController.text,
          surnameController.text,
          emailController.text,
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      /// SingleChildScrollView must be added to prevent overflow error
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
            child: SingleChildScrollView(
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
                      'Join Us',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppDividers.registerDivider,
                    15.h,
          
                    Row(
                      children: [
                        ///Name Textfield
                        MyTextField(
                          controller: nameController,
                          hint: 'Name',
                          isPassword: false,
                          width: 180,
                        ),
                        10.w,
          
                        ///Surname Textfield
                        MyTextField(
                          controller: surnameController,
                          hint: 'Surname',
                          isPassword: false,
                          width: 180,
                        )
                      ],
                    ),
                    10.h,
          
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
                    10.h,
                    // Confirm Password Textfield
                    MyTextField(
                      controller: confirmPasswordController,
                      hint: 'Confirm Password',
                      isPassword: true,
                    ),
                    20.h,
          
                    /// SignUp Button
                    MyButton(
                      title: 'Register',
                      onTap: signUp,
                    ),
                    15.h,
          
                    /// Register Line
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        7.w,
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login',
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
      ),
    );
  }
}
