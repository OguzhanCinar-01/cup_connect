import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/orders/widget/event_card.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
  const MyTimelineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.eventCard,
  });

  final bool isFirst;
  final bool isLast;
  final bool isPast;
  // ignore: prefer_typing_uninitialized_variables
  final eventCard;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /// gap between each timeline
      height: 140,
      width: double.infinity,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,

        /// line decorations
        beforeLineStyle: LineStyle(
          color: isPast ? AppColors.primary : Colors.grey.shade300,
          thickness: 4,
        ),

        /// decorate the icon
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isPast ? AppColors.primary : Colors.grey.shade300,
          iconStyle: IconStyle(
            iconData: Icons.done,
            color: isPast ? AppColors.onPrimary : Colors.grey.shade300,
          ),
        ),

        /// event card
        endChild: EventCard(
          isPast: isPast,
          child: eventCard,
        ),
      ),
    );
  }
}
