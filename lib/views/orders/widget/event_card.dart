import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.isPast,
    required this.child,
  });

  // ignore: prefer_typing_uninitialized_variables
  final child;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isPast ? AppColors.secondary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(child,
          style: GoogleFonts.poppins(
            color: AppColors.onSecondary,
            fontSize: 16,
          )),
    );
  }
}
