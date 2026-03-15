import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_bloc.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_event.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_state.dart';

class AllCarsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AllCarsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      title: Text('Ընտրիր մեքենա', style: AppTextStyles.headlineMedium),
      actions: const [
        _ViewModeButton(
            icon: Icons.view_list_rounded, mode: AllCarsViewMode.list),
        _ViewModeButton(
            icon: Icons.grid_view_rounded, mode: AllCarsViewMode.grid),
        _ViewModeButton(
            icon: Icons.slow_motion_video_rounded, mode: AllCarsViewMode.reels),
        SizedBox(width: 8),
      ],
    );
  }
}

class _ViewModeButton extends StatelessWidget {
  final IconData icon;
  final AllCarsViewMode mode;

  const _ViewModeButton({required this.icon, required this.mode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCarsFiltersBloc, AllCarsFiltersState>(
      buildWhen: (previous, current) => previous.viewMode != current.viewMode,
      builder: (context, state) {
        final isSelected = state.viewMode == mode;

        return GestureDetector(
          onTap: () {
            context
                .read<AllCarsFiltersBloc>()
                .add(AllCarsViewModeChanged(mode));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white54,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
