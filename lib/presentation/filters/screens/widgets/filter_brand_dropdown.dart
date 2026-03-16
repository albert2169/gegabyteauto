import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';

import '../../bloc/filters_bloc.dart';
import '../../bloc/filters_event.dart';

class FilterBrandDropdown extends StatelessWidget {
  const FilterBrandDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FiltersBloc>().state;

    return _FilterDropdownBase(
      label: 'Մակնիշ',
      value: state.selectedBrand,
      items: state.availableBrands,
      onChanged: (value) {
        context.read<FiltersBloc>().add(FiltersBrandChanged(value));
      },
    );
  }
}

class _FilterDropdownBase extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _FilterDropdownBase({
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
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: value != null
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              value: value,
              hint: Text(
                'Select $label',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 14,
                ),
              ),
              dropdownColor: const Color(0xFF1C1C1E),
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white.withValues(alpha: 0.5),
                size: 24,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(
                    'Բոլորը',
                    style:
                        TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                  ),
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
