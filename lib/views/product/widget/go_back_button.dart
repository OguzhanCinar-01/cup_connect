import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/product/viewmodel/size_button_model.dart';
import 'package:coffee_shop/views/product/viewmodel/syrup_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            onPressed: () async {
              /// Go back to the previous page
              NavigationManager.instance.goBack();

              /// Delay the reset of the selected size to avoid the animation
              await Future.delayed(const Duration(milliseconds: 300));

              /// Reset the selected size
              // ignore: use_build_context_synchronously
              Provider.of<SizeButtonModel>(context, listen: false)
                  .resetSelectedSize();
              /// Reset the selected syrup    
              // ignore: use_build_context_synchronously
              Provider.of<SyrupModel>(context, listen: false)
                  .selectSyrup('Classic');
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
