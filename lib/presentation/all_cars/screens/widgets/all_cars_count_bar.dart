import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_bloc.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_event.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart';

class AllCarsCountBar extends StatelessWidget {
  const AllCarsCountBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsBloc, CarsState>(
      buildWhen: (previous, current) =>
          previous.filteredCars.length != current.filteredCars.length ||
          previous.activeFilterCount != current.activeFilterCount,
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
              if (state.activeFilterCount > 0)
                GestureDetector(
                  onTap: () {
                    context.read<CarsBloc>().add(const CarsFiltersClear());
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
