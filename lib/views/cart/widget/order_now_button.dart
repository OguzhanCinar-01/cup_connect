import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderNowButton extends StatelessWidget {
  const OrderNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// Add items to orders screen
      },
      child: Container(
        width: 250,
        height: 65,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary,
        ),
        child: Center(
          child: Text(
            AppStr.orderNow,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
