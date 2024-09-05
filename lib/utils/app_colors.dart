import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.brown;
  static const Color onPrimary = Colors.white;

  static const Color secondary = Color(0XffEAD8C0);
  static const Color onSecondary = Colors.black;

  static const Color surface = Color(0xFFF8F4E1);
  static const Color onSurface = Colors.black;

  static  Color primarySurface = Colors.brown.shade800;

  static Color error = Colors.red.shade900;
  
  static Color orderStatusRed = const Color.fromARGB(255, 255, 204, 203);
  static Color orderStatusGreen = const Color.fromARGB(255, 198, 221, 203);

  static Color completeOrderButtonColor = const Color.fromRGBO(181, 145, 132, 1);

  static Color showSuccessDialogColor = const Color.fromARGB(255, 24, 85, 25);
  static Color showInfoDialogColor = const Color.fromARGB(255, 3, 52, 110);
}
