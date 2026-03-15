import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_bloc.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_event.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_state.dart';

class AllCarsCountBar extends StatelessWidget {
  const AllCarsCountBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCarsFiltersBloc, AllCarsFiltersState>(
      buildWhen: (previous, current) =>
          previous.filteredCars.length != current.filteredCars.length ||
          previous.hasActiveFilters != current.hasActiveFilters,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              Text(
                '${state.filteredCars.length} cars found',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
              if (state.hasActiveFilters)
                GestureDetector(
                  onTap: () {
                    context
                        .read<AllCarsFiltersBloc>()
                        .add(const AllCarsFiltersReset());
                  },
                  child: Text(
                    'Clear all',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
