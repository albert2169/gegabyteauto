import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class MainScreenSectionItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;
  final Color color;
  final Color accentColor;
  final Function() onTap;
  const MainScreenSectionItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(iconData, color: accentColor, size: 18),
            ),
            const Spacer(),
            Text(title,
                style: AppTextStyles.headlineSmall.copyWith(fontSize: 14)),
            const SizedBox(height: 2),
            Text(subtitle,
                style: AppTextStyles.bodySmall.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
