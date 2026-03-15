import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_bloc.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_event.dart';

class AllCarsEmptyState extends StatelessWidget {
  const AllCarsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey('empty'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            color: Colors.white.withValues(alpha: 0.15),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text('No cars found', style: AppTextStyles.headlineMedium),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              context
                  .read<AllCarsFiltersBloc>()
                  .add(const AllCarsFiltersReset());
            },
            child: Text(
              'Reset filters',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
