import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class AllCarsLoadingView extends StatelessWidget {
  const AllCarsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 44,
            child: Row(
              children: [
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: AppColors.surfaceVariant,
                    highlightColor: AppColors.surface,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Shimmer.fromColors(
                  baseColor: AppColors.surfaceVariant,
                  highlightColor: AppColors.surface,
                  child: Container(
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: AppColors.surfaceVariant,
              highlightColor: AppColors.surface,
              child: ListView.separated(
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, __) => Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
