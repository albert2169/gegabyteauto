import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_bloc.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_event.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart';

class AllCarsSearchBar extends StatefulWidget {
  final VoidCallback? onFiltersTap;

  const AllCarsSearchBar({super.key, this.onFiltersTap});

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
                  context.read<CarsBloc>().add(CarsSearchQueryChanged(value));
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
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            context
                                .read<CarsBloc>()
                                .add(const CarsSearchQueryChanged(''));
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
          BlocBuilder<CarsBloc, CarsState>(
            buildWhen: (previous, current) =>
                previous.activeFilterCount != current.activeFilterCount,
            builder: (context, state) {
              return GestureDetector(
                onTap: widget.onFiltersTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: state.activeFilterCount > 0
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Icon(Icons.tune, color: Colors.white, size: 22),
                      ),
                      if (state.activeFilterCount > 0)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${state.activeFilterCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
