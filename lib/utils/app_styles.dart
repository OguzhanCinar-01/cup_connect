import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static final TextStyle titleTextStyle = GoogleFonts.poppins(
    fontSize: 25,
    fontWeight: FontWeight.w200,
    color: Colors.black,
  );
  static final TextStyle orderTextStyle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
  static final TextStyle productTitle = GoogleFonts.poppins(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static final TextStyle description = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
  static final TextStyle price = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static final TextStyle priceTextStyle = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static final TextStyle priceTextStyleBold = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static final TextStyle profileText = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: AppColors.onPrimary,
  );
  static final TextStyle orderDetailsText = GoogleFonts.lato(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static final TextStyle orderDetailsProduct = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static final TextStyle orderDetailsPrice = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static final TextStyle aboutTitle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static final TextStyle aboutText = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
}
