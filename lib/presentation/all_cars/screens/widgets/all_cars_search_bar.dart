import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_bloc.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_event.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_state.dart';

class AllCarsSearchBar extends StatefulWidget {
  const AllCarsSearchBar({super.key});

  @override
  State<AllCarsSearchBar> createState() => _AllCarsSearchBarState();
}

class _AllCarsSearchBarState extends State<AllCarsSearchBar> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCarsFiltersBloc, AllCarsFiltersState>(
      buildWhen: (previous, current) =>
          previous.searchQuery != current.searchQuery ||
          previous.showFilters != current.showFilters ||
          previous.hasActiveFilters != current.hasActiveFilters,
      builder: (context, state) {
        if (_searchController.text != state.searchQuery) {
          _searchController.text = state.searchQuery;
          _searchController.selection = TextSelection.collapsed(
            offset: _searchController.text.length,
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: AppTextStyles.bodyMedium,
                    onChanged: (value) {
                      context
                          .read<AllCarsFiltersBloc>()
                          .add(AllCarsSearchQueryChanged(value));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search brand, model, color...',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.3),
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withValues(alpha: 0.4),
                        size: 22,
                      ),
                      suffixIcon: state.searchQuery.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                context
                                    .read<AllCarsFiltersBloc>()
                                    .add(const AllCarsSearchQueryChanged(''));
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.white.withValues(alpha: 0.4),
                                size: 20,
                              ),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  context
                      .read<AllCarsFiltersBloc>()
                      .add(const AllCarsFilterPanelToggled());
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: state.showFilters || state.hasActiveFilters
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Icon(Icons.tune, color: Colors.white, size: 22),
                      ),
                      if (state.hasActiveFilters)
                        const Positioned(
                          top: 6,
                          right: 6,
                          child: _FilterActiveDot(),
                        ),
                    ],
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

class _FilterActiveDot extends StatelessWidget {
  const _FilterActiveDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFF2ECC71),
        shape: BoxShape.circle,
      ),
    );
  }
}
