import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.isPassword,
  });
  final TextEditingController controller;
  final String hint;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: !isPassword ?TextInputType.emailAddress : TextInputType.text,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hint,
        fillColor: Colors.grey[400],
        filled: true,
      ),
    );
  }
}
