import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: AppColors.primary,
      strokeWidth: 2.5,
      strokeAlign: BorderSide.strokeAlignCenter,
    );
  }
}
