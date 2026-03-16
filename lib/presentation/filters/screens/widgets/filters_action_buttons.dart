import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/commons/widgets/custom_button.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/models/car_filter_view_model.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_event.dart';

import '../../bloc/filters_bloc.dart';
import '../../bloc/filters_state.dart';

class FiltersActionButtons extends StatefulWidget {
  final VoidCallback? onApply;

  const FiltersActionButtons({super.key, this.onApply});

  @override
  State<FiltersActionButtons> createState() => _FiltersActionButtonsState();
}

class _FiltersActionButtonsState extends State<FiltersActionButtons> {
  late FiltersBloc _filtersBloc;

  @override
  void initState() {
    super.initState();
    _filtersBloc = getIt<FiltersBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            top: 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () {
                    _filtersBloc.add(CloseWithoutApplyingEvent());
                    context.router.maybePop<CarFilterViewModel?>(null);
                  },
                  isOutlined: true,
                  textStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  text: 'Չեղարկել',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  isOutlined: false,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  text: 'Կիրառել',
                  onTap: () {
                    _filtersBloc.add(ApplyFiltersEvent());
                    context.router.maybePop<CarFilterViewModel?>(
                        state.carFilterViewModel);
                  },
                  color: AppColors.primary,
                ),
              )

              //         if (state.activeFilterCount > 0) ...[
              //           const SizedBox(width: 8),
              //           Container(
              //             padding: const EdgeInsets.symmetric(
              //               horizontal: 8,
              //               vertical: 2,
              //             ),
              //             decoration: BoxDecoration(
              //               color: Colors.white.withValues(alpha: 0.2),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Text(
              //               '${state.activeFilterCount}',
              //               style: const TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
