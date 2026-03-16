import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';

import '../../bloc/filters_bloc.dart';
import '../../bloc/filters_state.dart';
import '../../bloc/filters_event.dart';

class FiltersHeader extends StatelessWidget implements PreferredSizeWidget {
  const FiltersHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          context.router.maybePop(null);
        },
        icon: const Icon(Icons.close, color: Colors.white),
      ),
      title: const Text(
        'Filters',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        BlocBuilder<FiltersBloc, FiltersState>(
          buildWhen: (previous, current) =>
              previous.hasActiveFilters != current.hasActiveFilters,
          builder: (context, state) {
            if (!state.hasActiveFilters) {
              return const SizedBox.shrink();
            }

            return TextButton(
              onPressed: () {
                context.read<FiltersBloc>().add(const FiltersResetRequested());
              },
              child: Text(
                'Reset',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
