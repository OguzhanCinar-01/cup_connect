import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppDividers {
  static const loginDivider = Divider(
    color: AppColors.secondary,
    indent: 100,
    endIndent: 100,
  );
  static const registerDivider = Divider(
    color: AppColors.secondary,
    indent: 130,
    endIndent: 130,
  );
  static const showMessaseDialogDivider = Divider(
    color: Colors.black,
    thickness: 0.5,
  );
  static const orderCardDivider = Divider(
    color: AppColors.onPrimary,
    thickness: 1,
  );
  static const homeViewDivider = Divider(
    color: Colors.black,
    thickness: 0.2,
  );
  static const cartViewDivider = Divider(
    indent: 100,
    endIndent: 100,
    height: 10,
    color: AppColors.onSecondary,
    thickness: 0.2,
  );
  static const aboutUsDivider = Divider(
    color: AppColors.onSecondary,
    thickness: 0.1,
    endIndent: 230,
  );
  static const previousOrdersDivider = Divider(
    color: AppColors.onSecondary,
    thickness: 0.2,
    endIndent: 180,
    indent: 35,
  );
  static const productViewDivider = Divider(
    color: AppColors.primary,
    thickness: 0.3,
    indent: 40,
    endIndent: 40,
  );
}
