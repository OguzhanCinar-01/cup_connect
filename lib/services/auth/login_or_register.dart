import '../../views/login/view/login_view.dart';
import '../../views/login/view/register_view.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() => showLoginPage = !showLoginPage);
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return  LoginView(onTap: togglePages);
    } else {
      return  RegisterView(onTap: togglePages);
    }
  }
}
