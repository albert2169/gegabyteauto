import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_bloc.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_event.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_state.dart';

class AllCarsFilterPanel extends StatelessWidget {
  const AllCarsFilterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCarsFiltersBloc, AllCarsFiltersState>(
      buildWhen: (previous, current) =>
          previous.showFilters != current.showFilters ||
          previous.selectedBrand != current.selectedBrand ||
          previous.selectedGearBox != current.selectedGearBox ||
          previous.selectedEngine != current.selectedEngine ||
          previous.priceRange != current.priceRange ||
          previous.yearRange != current.yearRange ||
          previous.brands != current.brands ||
          previous.gearBoxes != current.gearBoxes ||
          previous.engines != current.engines,
      builder: (context, state) {
        if (!state.showFilters) {
          return const SizedBox.shrink();
        }

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FilterDropdown(
                  label: 'Brand',
                  value: state.selectedBrand,
                  items: state.brands,
                  onChanged: (value) {
                    context
                        .read<AllCarsFiltersBloc>()
                        .add(AllCarsBrandChanged(value));
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _FilterDropdown(
                        label: 'Gearbox',
                        value: state.selectedGearBox,
                        items: state.gearBoxes,
                        onChanged: (value) {
                          context
                              .read<AllCarsFiltersBloc>()
                              .add(AllCarsGearBoxChanged(value));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _FilterDropdown(
                        label: 'Engine',
                        value: state.selectedEngine,
                        items: state.engines,
                        onChanged: (value) {
                          context
                              .read<AllCarsFiltersBloc>()
                              .add(AllCarsEngineChanged(value));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _RangeFilterSlider(
                  label: 'Price',
                  values: state.priceRange,
                  min: 0,
                  max: 250000,
                  prefix: r'$',
                  onChanged: (range) {
                    context
                        .read<AllCarsFiltersBloc>()
                        .add(AllCarsPriceRangeChanged(range));
                  },
                ),
                const SizedBox(height: 12),
                _RangeFilterSlider(
                  label: 'Year',
                  values: state.yearRange,
                  min: 2015,
                  max: 2025,
                  prefix: '',
                  divisions: 10,
                  onChanged: (range) {
                    context
                        .read<AllCarsFiltersBloc>()
                        .add(AllCarsYearRangeChanged(range));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              value: value,
              hint: Text(
                'All',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3), fontSize: 13),
              ),
              dropdownColor: const Color(0xFF1C1C1E),
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white.withValues(alpha: 0.4),
                size: 20,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 13),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('All', style: TextStyle(color: Colors.white54)),
                ),
                ...items.map(
                  (item) => DropdownMenuItem<String?>(
                    value: item,
                    child: Text(item),
                  ),
                ),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _RangeFilterSlider extends StatelessWidget {
  final String label;
  final RangeValues values;
  final double min;
  final double max;
  final String prefix;
  final int? divisions;
  final ValueChanged<RangeValues> onChanged;

  const _RangeFilterSlider({
    required this.label,
    required this.values,
    required this.min,
    required this.max,
    required this.prefix,
    required this.onChanged,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              '$prefix${values.start.round()} - $prefix${values.end.round()}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
            thumbColor: Colors.white,
            overlayColor: AppColors.primary.withValues(alpha: 0.15),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
            trackHeight: 3,
          ),
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
