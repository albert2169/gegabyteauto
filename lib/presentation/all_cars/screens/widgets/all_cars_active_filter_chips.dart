import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_bloc.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_event.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_state.dart';

class AllCarsActiveFilterChips extends StatelessWidget {
  const AllCarsActiveFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCarsFiltersBloc, AllCarsFiltersState>(
      buildWhen: (previous, current) =>
          previous.selectedBrand != current.selectedBrand ||
          previous.selectedGearBox != current.selectedGearBox ||
          previous.selectedEngine != current.selectedEngine,
      builder: (context, state) {
        final chips = <Widget>[];

        if (state.selectedBrand != null) {
          chips.add(
            _ActiveChip(
              label: state.selectedBrand!,
              onRemove: () {
                context.read<AllCarsFiltersBloc>().add(
                      const AllCarsFilterRemoved(AllCarsRemovableFilter.brand),
                    );
              },
            ),
          );
        }

        if (state.selectedGearBox != null) {
          chips.add(
            _ActiveChip(
              label: state.selectedGearBox!,
              onRemove: () {
                context.read<AllCarsFiltersBloc>().add(
                      const AllCarsFilterRemoved(
                          AllCarsRemovableFilter.gearBox),
                    );
              },
            ),
          );
        }

        if (state.selectedEngine != null) {
          chips.add(
            _ActiveChip(
              label: state.selectedEngine!,
              onRemove: () {
                context.read<AllCarsFiltersBloc>().add(
                      const AllCarsFilterRemoved(AllCarsRemovableFilter.engine),
                    );
              },
            ),
          );
        }

        if (chips.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: chips.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (_, index) => chips[index],
            ),
          ),
        );
      },
    );
  }
}

class _ActiveChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _ActiveChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, color: Colors.white54, size: 14),
          ),
        ],
      ),
    );
  }
}
