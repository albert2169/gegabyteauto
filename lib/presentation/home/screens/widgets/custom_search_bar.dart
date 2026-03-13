import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(const AllCarsRoute()),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.search_rounded,
                  color: AppColors.textHint, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Փնտրիր ըստ բրենդի, մոդելի, տարեթվի...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textHint),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
