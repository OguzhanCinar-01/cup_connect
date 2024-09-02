import 'package:coffee_shop/extensions/space_exs.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_strings.dart';
import 'package:coffee_shop/utils/app_styles.dart';
import 'package:coffee_shop/utils/cupconnect_logo.dart';
import '../../home/widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        toolbarHeight: 70,
        title: const CupConnectLogo(
          fontSize: 30,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// Divider
          const Divider(
            color: AppColors.onSecondary,
            thickness: 0.2,
          ),

          /// About Us
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'About Us',
              style: AppStyle.titleTextStyle,
            ),
          ),
          /// Divider
          const Divider(
            color: AppColors.onSecondary,
            thickness: 0.1,
            endIndent: 230,
          ),
          15.h,

          /// About Us Text
          Text.rich(
            TextSpan(
              text: 'Version: ',
              style: AppStyle.aboutTitle,
              children: [
                TextSpan(text: '1.0.0', style: AppStyle.aboutText),
              ],
            ),
          ),
          15.h,

          /// Developer Text
          Text.rich(
            TextSpan(
              text: 'Developer: ',
              style: AppStyle.aboutTitle,
              children: [
                TextSpan(text: AppStr.developer, style: AppStyle.aboutText),
              ],
            ),
          ),
          15.h,

          /// About Text
          Text.rich(
            TextSpan(
              text: 'About: ',
              style: AppStyle.aboutTitle,
              children: [
                TextSpan(
                    text:
                        'CupConnect is a specially designed application for coffee lovers. Users can explore their favorite coffee varieties, place orders, and get detailed information about coffee. Our user-friendly interface allows you to complete your coffee orders quickly and easily.',
                    style: AppStyle.aboutText),
              ],
            ),
          ),
          15.h,
          Text.rich(
            TextSpan(
              text: 'Features: \n',
              style: AppStyle.aboutTitle,
              children: [
                TextSpan(
                    text: '-  Extensive coffee menu',
                    style: AppStyle.aboutText),
                TextSpan(
                    text: '\n-  Detailed coffee information',
                    style: AppStyle.aboutText),
                TextSpan(
                    text:
                        '\n-  Customizable orders according to personal preferences',
                    style: AppStyle.aboutText),
              ],
            ),
          ),
          15.h,

          /// Feedback Text
          Text.rich(
            TextSpan(
              text: 'Feedback: ',
              style: AppStyle.aboutTitle,
              children: [
                TextSpan(
                  text:
                      'We would love to hear your thoughts on our app. You can reach out to us with feedback at [${AppStr.contactMail}].',
                  style: AppStyle.aboutText,
                ),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
