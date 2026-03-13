import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class MainScreenCategoryItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  const MainScreenCategoryItem(
      {super.key, required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: AppColors.textSecondary, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(fontSize: 9.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
