import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_bloc.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_event.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_app_bar.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_count_bar.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_empty_state.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_error_view.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_list_view.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_loading_view.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_search_bar.dart';
import 'package:gegabyteauto/presentation/all_cars/widgets/car_grid_view.dart';
import 'package:gegabyteauto/presentation/all_cars/widgets/car_reels_view.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_state.dart'
    hide LoadState;

@RoutePage()
class AllCarsScreen extends StatelessWidget {
  const AllCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CarsBloc>()..add(const CarsLoadRequested()),
      child: const _AllCarsScreenContent(),
    );
  }
}

class _AllCarsScreenContent extends StatelessWidget {
  const _AllCarsScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AllCarsAppBar(),
      body: SafeArea(
        top: false,
        child: BlocBuilder<CarsBloc, CarsState>(
          buildWhen: (previous, current) =>
              previous.loadState != current.loadState,
          builder: (context, state) {
            switch (state.loadState) {
              case LoadState.initial:
              case LoadState.loading:
                return const AllCarsLoadingView();
              case LoadState.error:
                return AllCarsErrorView(
                    message: state.errorMessage ?? 'An error occurred');
              case LoadState.loaded:
                return const _AllCarsBody();
            }
          },
        ),
      ),
    );
  }
}

class _AllCarsBody extends StatelessWidget {
  const _AllCarsBody();

  Future<void> _onFiltersTap(BuildContext context) async {
    final carsBloc = context.read<CarsBloc>();
    final result = await context.router.push<FiltersState>(
      FiltersRoute(cars: carsBloc.state.allCars),
    );
    if (result != null) {
      carsBloc.add(CarsFiltersApplied(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsBloc, CarsState>(
      builder: (context, state) {
        return Column(
          children: [
            AllCarsSearchBar(
              onFiltersTap: () => _onFiltersTap(context),
            ),
            const AllCarsCountBar(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: state.filteredCars.isEmpty && state.allCars.isNotEmpty
                    ? const AllCarsEmptyState()
                    : Builder(
                        builder: (context) {
                          switch (state.viewMode) {
                            case CarsViewMode.list:
                              return AllCarsListView(cars: state.filteredCars);
                            case CarsViewMode.grid:
                              return CarGridView(
                                  key: const ValueKey('grid'),
                                  cars: state.filteredCars);
                            case CarsViewMode.reels:
                              return CarReelsView(
                                  key: const ValueKey('reels'),
                                  cars: state.filteredCars);
                          }
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
