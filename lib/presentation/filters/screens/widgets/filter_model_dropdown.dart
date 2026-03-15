import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';

import '../../bloc/filters_bloc.dart';
import '../../bloc/filters_state.dart';
import '../../bloc/filters_event.dart';

class FilterModelDropdown extends StatelessWidget {
  const FilterModelDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      buildWhen: (previous, current) =>
          previous.selectedModel != current.selectedModel ||
          previous.availableModels != current.availableModels ||
          previous.selectedBrand != current.selectedBrand,
      builder: (context, state) {
        final isEnabled = state.selectedBrand != null;

        return _FilterDropdownBase(
          label: 'Model',
          value: state.selectedModel,
          items: state.availableModels,
          enabled: isEnabled,
          hint: isEnabled ? 'Select Model' : 'Select Brand first',
          onChanged: isEnabled
              ? (value) {
                  context.read<FiltersBloc>().add(FiltersModelChanged(value));
                }
              : null,
        );
      },
    );
  }
}

class _FilterDropdownBase extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final bool enabled;
  final String hint;
  final ValueChanged<String?>? onChanged;

  const _FilterDropdownBase({
    required this.label,
    required this.value,
    required this.items,
    this.enabled = true,
    required this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: enabled ? Colors.white70 : Colors.white38,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Opacity(
          opacity: enabled ? 1.0 : 0.5,
          child: Container(
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
                  hint,
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
                items: enabled
                    ? [
                        DropdownMenuItem<String?>(
                          value: null,
                          child: Text(
                            'All',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6)),
                          ),
                        ),
                        ...items.map(
                          (item) => DropdownMenuItem<String?>(
                            value: item,
                            child: Text(item),
                          ),
                        ),
                      ]
                    : null,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
