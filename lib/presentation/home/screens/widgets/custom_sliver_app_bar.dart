import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/presentation/commons/widgets/app_logo.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      floating: true,
      titleSpacing: 20,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            AppLogo(),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
