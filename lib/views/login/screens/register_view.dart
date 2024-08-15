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

  /// Sign Up Function
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password does not match'),
        ),
      );
      return;
    }

    /// get authservice
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Join Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
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
    );
  }
}
