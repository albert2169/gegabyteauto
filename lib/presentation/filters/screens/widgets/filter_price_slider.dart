import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';

import '../../bloc/filters_bloc.dart';
import '../../bloc/filters_state.dart';
import '../../bloc/filters_event.dart';

class FilterPriceSlider extends StatelessWidget {
  const FilterPriceSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      buildWhen: (previous, current) =>
          previous.priceRange != current.priceRange,
      builder: (context, state) {
        final isModified = state.priceRange != FiltersState.defaultPriceRange;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price Range',
                  style: TextStyle(
                    color: isModified ? AppColors.primary : Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$${state.priceRange.start.toInt()} - \$${state.priceRange.end.toInt()}',
                  style: TextStyle(
                    color: isModified ? AppColors.primary : Colors.white54,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: Colors.white.withValues(alpha: 0.15),
                thumbColor: AppColors.primary,
                overlayColor: AppColors.primary.withValues(alpha: 0.2),
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: 8,
                ),
              ),
              child: RangeSlider(
                values: state.priceRange,
                min: FiltersState.defaultPriceRange.start,
                max: FiltersState.defaultPriceRange.end,
                divisions: 50,
                onChanged: (range) {
                  context
                      .read<FiltersBloc>()
                      .add(FiltersPriceRangeChanged(range));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${FiltersState.defaultPriceRange.start.toInt()}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '\$${FiltersState.defaultPriceRange.end.toInt()}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
