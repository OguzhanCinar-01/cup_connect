import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';

class SizeButton extends StatelessWidget {
  const SizeButton({
    super.key,
    required this.sizeButtonTitle,
    this.sizeButtonWidth = 100,
    this.sizeButtonHeight = 45,
    this.sizeButtonFontSize = 16,
  });

  final String sizeButtonTitle;

  final double sizeButtonWidth;
  final double sizeButtonHeight;
  final double sizeButtonFontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(sizeButtonTitle);
      },
      child: Container(
        alignment: Alignment.center,
        width: sizeButtonWidth,
        height: sizeButtonHeight,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          sizeButtonTitle,
          style: GoogleFonts.lato(
            color: AppColors.surface,
            fontWeight: FontWeight.bold,
            fontSize: sizeButtonFontSize,
          ),
        ),
      ),
    );
  }
}
