import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  final double sizeButtonWidth = 250;
  final double sizeButtonHeight = 70;
  final double sizeButtonFontSize = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: sizeButtonWidth,
        height: sizeButtonHeight,
        decoration: BoxDecoration(
          color: AppColors.primary ,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          /// Product price will be added here
          'Add to Cart  |   \$ ${4.99}',
          style: GoogleFonts.lato(
            color: AppColors.surface,
            fontWeight: FontWeight.bold,
            fontSize: sizeButtonFontSize,
          ),
        ),
      );
  }
}