import 'package:coffee_shop/views/product/viewmodel/size_button_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors.dart';

class SizeButton extends StatelessWidget {
  const SizeButton({
    super.key,
    required this.sizeButtonTitle,
    required this.index,
  });
  final int index;
  final String sizeButtonTitle;

  final double sizeButtonWidth = 100;
  final double sizeButtonHeight = 40;
  final double sizeButtonFontSize = 16;

  @override
  Widget build(BuildContext context) {
    final sizeButtonModel = Provider.of<SizeButtonModel>(context);
    final isSelected = sizeButtonModel.selectedSize == index;

    return GestureDetector(
      onTap: () {
        sizeButtonModel.setSelectedSize(index);
      },
      child: Container(
        alignment: Alignment.center,
        width: sizeButtonWidth,
        height: sizeButtonHeight,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.secondary,
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
