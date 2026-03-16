import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/models/car_filter_view_model.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_bloc.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_event.dart';

class AllCarsErrorView extends StatelessWidget {
  final CarFilterViewModel appliedFilters;
  final String searchText;
  final String message;

  const AllCarsErrorView({
    super.key,
    required this.message,
    required this.searchText,
    required this.appliedFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 56, color: AppColors.error),
            const SizedBox(height: 16),
            Text('Something went wrong', style: AppTextStyles.headlineMedium),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<CarsBloc>().add(FetchAllCarsEvent(
                      searchText: searchText,
                      appliedFilters: appliedFilters,
                    ));
              },
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
