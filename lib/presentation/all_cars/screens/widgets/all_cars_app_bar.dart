import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_bloc.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_event.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart';

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
      title: Text('Փնտրել', style: AppTextStyles.headlineMedium),
      actions: const [
        _ViewModeButton(icon: Icons.view_list_rounded, mode: CarsViewMode.list),
        _ViewModeButton(icon: Icons.grid_view_rounded, mode: CarsViewMode.grid),
        _ViewModeButton(
            icon: Icons.slow_motion_video_rounded, mode: CarsViewMode.reels),
        SizedBox(width: 8),
      ],
    );
  }
}

class _ViewModeButton extends StatelessWidget {
  final IconData icon;
  final CarsViewMode mode;

  const _ViewModeButton({required this.icon, required this.mode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsBloc, CarsState>(
      buildWhen: (previous, current) => previous.viewMode != current.viewMode,
      builder: (context, state) {
        final isSelected = state.viewMode == mode;

        return GestureDetector(
          onTap: () {
            context.read<CarsBloc>().add(CarsViewModeChanged(mode));
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
