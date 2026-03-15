import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_bloc.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_event.dart';
import 'package:gegabyteauto/commons/state/filters_bloc/all_cars_filters/all_cars_filters_state.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_bloc.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_event.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_active_filter_chips.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_app_bar.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_count_bar.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_empty_state.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_error_view.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_filter_panel.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_list_view.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_loading_view.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_search_bar.dart';
import 'package:gegabyteauto/presentation/all_cars/widgets/car_grid_view.dart';
import 'package:gegabyteauto/presentation/all_cars/widgets/car_reels_view.dart';

@RoutePage()
class AllCarsScreen extends StatelessWidget {
  const AllCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CarsBloc>()..add(const CarsLoadRequested()),
        ),
        BlocProvider(
          create: (_) => AllCarsFiltersBloc(),
        ),
      ],
      child: const _AllCarsView(),
    );
  }
}

class _AllCarsView extends StatelessWidget {
  const _AllCarsView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CarsBloc, CarsState>(
      listenWhen: (_, current) => current is CarsLoaded,
      listener: (context, state) {
        if (state is CarsLoaded) {
          context
              .read<AllCarsFiltersBloc>()
              .add(AllCarsSourceUpdated(allCars: state.allCars));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const AllCarsAppBar(),
        body: SafeArea(
          top: false,
          child: BlocBuilder<CarsBloc, CarsState>(
            builder: (context, state) {
              if (state is CarsLoading) {
                return const AllCarsLoadingView();
              }

              if (state is CarsError) {
                return AllCarsErrorView(message: state.message);
              }

              return BlocBuilder<AllCarsFiltersBloc, AllCarsFiltersState>(
                builder: (context, filtersState) {
                  return Column(
                    children: [
                      const AllCarsSearchBar(),
                      const AllCarsFilterPanel(),
                      const AllCarsActiveFilterChips(),
                      const AllCarsCountBar(),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: filtersState.filteredCars.isEmpty &&
                                  filtersState.allCars.isNotEmpty
                              ? const AllCarsEmptyState()
                              : Builder(
                                  builder: (context) {
                                    switch (filtersState.viewMode) {
                                      case AllCarsViewMode.list:
                                        return AllCarsListView(
                                            cars: filtersState.filteredCars);
                                      case AllCarsViewMode.grid:
                                        return CarGridView(
                                            key: const ValueKey('grid'),
                                            cars: filtersState.filteredCars);
                                      case AllCarsViewMode.reels:
                                        return CarReelsView(
                                            key: const ValueKey('reels'),
                                            cars: filtersState.filteredCars);
                                    }
                                  },
                                ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
