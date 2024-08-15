import '../../../extensions/space_exs.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/cupconnect_logo.dart';
import 'package:flutter/material.dart';

class HomeViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.surface,
        width: double.infinity,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 130,
          ),
          child: Row(
            children: [
              ///Logo
              const CupConnectLogo(
                fontSize: 30,
                color: Colors.black,
              ),
              80.w,

              ///Notification icon
              const Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
