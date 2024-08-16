import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(right: 300),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.onPrimary,
          // color: AppColors.onPrimary,
        ),
        child: IconButton(
            onPressed: () {
              /// Go back to the previous page
              NavigationManager.instance.goBack();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
            ),
            color: Colors.white),
      ),
    );
  }
}
