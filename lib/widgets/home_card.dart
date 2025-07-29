import 'package:flutter/material.dart';

import '../main.dart';

//card to represent status in home screen
class HomeCard extends StatelessWidget {
  final String? title, subtitle;
  final Widget? icon;
  final bool brake;

  const HomeCard({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.brake = true,
  });

  @override
  Widget build(BuildContext context) {
    // Check if both title and subtitle are empty or null
    bool isTitleEmpty = title == null || title!.isEmpty;
    bool isSubtitleEmpty = subtitle == null || subtitle!.isEmpty;
    bool bothEmpty = isTitleEmpty && isSubtitleEmpty;

    return SizedBox(
      width: brake ? mq.width * .45 : null,
      child: Column(
        mainAxisAlignment: bothEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          // Show icon only if provided
          if (icon != null) ...[
            icon!,
            // Only add spacing if there's content below
            if (!bothEmpty) const SizedBox(height: 6),
          ],

          // Show title only if provided and not empty
          if (title != null && title!.isNotEmpty) ...[
            Text(
              title!,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6),
          ],

          // Show subtitle only if provided and not empty
          if (subtitle != null && subtitle!.isNotEmpty)
            Text(
              subtitle!,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[400]
                    : Colors.grey[600],
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}