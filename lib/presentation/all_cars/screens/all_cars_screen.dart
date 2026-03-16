import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/models/car_filter_view_model.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_bloc.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_event.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_app_bar.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_empty_state.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_error_view.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_list_view.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_loading_view.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/widgets/all_cars_search_bar.dart';
import 'package:gegabyteauto/presentation/all_cars/widgets/car_grid_view.dart';
import 'package:gegabyteauto/presentation/all_cars/widgets/car_reels_view.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_bloc.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_state.dart'
    hide LoadState;

@RoutePage()
class AllCarsScreen extends StatefulWidget {
  final FiltersState? preAppliedFilters;

  const AllCarsScreen({super.key, this.preAppliedFilters});

  @override
  State<AllCarsScreen> createState() => _AllCarsScreenState();
}

class _AllCarsScreenState extends State<AllCarsScreen> {
  late FiltersBloc _filtersBloc;

  @override
  void initState() {
    super.initState();
    _filtersBloc = getIt<FiltersBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CarsBloc>(),
      child: _AllCarsScreenContent(
        filtersBloc: _filtersBloc,
      ),
    );
  }
}

class _AllCarsScreenContent extends StatefulWidget {
  final FiltersBloc filtersBloc;
  const _AllCarsScreenContent({required this.filtersBloc});

  @override
  State<_AllCarsScreenContent> createState() => _AllCarsScreenContentState();
}

class _AllCarsScreenContentState extends State<_AllCarsScreenContent> {
  late final TextEditingController _searchTextEditingController;
  late final CarsBloc _carsBloc;

  @override
  void initState() {
    super.initState();
    _searchTextEditingController = TextEditingController();
    _carsBloc = getIt<CarsBloc>()
      ..add(FetchAllCarsEvent(
        searchText: '',
        appliedFilters: CarFilterViewModel(),
        isInitialFetch: true,
      ));
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AllCarsAppBar(),
      body: SafeArea(
        top: false,
        child: BlocBuilder<CarsBloc, CarsState>(
          builder: (context, state) {
            switch (state.loadState) {
              case LoadState.initial:
              case LoadState.loading:
                return const AllCarsLoadingView();
              case LoadState.error:
                return AllCarsErrorView(
                    searchText: _searchTextEditingController.text,
                    appliedFilters:
                        widget.filtersBloc.state.carFilterViewModel,
                    message: state.errorMessage ?? 'An error occurred');
              case LoadState.loaded:
                return BlocBuilder<CarsBloc, CarsState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        AllCarsSearchBar(
                          searchEditingController: _searchTextEditingController,
                          onFiltersTap: () => _onFiltersTap(context),
                        ),
                        //    const AllCarsCountBar(),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: state.allCars.isEmpty
                                ? const AllCarsEmptyState()
                                : Builder(
                                    builder: (context) {
                                      switch (state.viewMode) {
                                        case CarsViewMode.list:
                                          return AllCarsListView(
                                              cars: state.allCars);
                                        case CarsViewMode.grid:
                                          return CarGridView(
                                              key: const ValueKey('grid'),
                                              cars: state.allCars);
                                        case CarsViewMode.reels:
                                          return CarReelsView(
                                              key: const ValueKey('reels'),
                                              cars: state.allCars);
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
          },
        ),
      ),
    );
  }

  Future<void> _onFiltersTap(BuildContext context) async {
    final carFilterViewModel = await context.router.push<CarFilterViewModel?>(
      FiltersRoute(),
    );
    if (carFilterViewModel != null) {
      _carsBloc.add(FetchAllCarsEvent(
        appliedFilters: carFilterViewModel,
        searchText: _searchTextEditingController.text,
      ));
    }
  }
}
