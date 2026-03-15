import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/presentation/view_models/car_view_model.dart';

import 'all_cars_filters_event.dart';
import 'all_cars_filters_state.dart';

class AllCarsFiltersBloc
    extends Bloc<AllCarsFiltersEvent, AllCarsFiltersState> {
  AllCarsFiltersBloc() : super(const AllCarsFiltersState.initial()) {
    on<AllCarsSourceUpdated>(_onSourceUpdated);
    on<AllCarsSearchQueryChanged>(_onSearchQueryChanged);
    on<AllCarsFilterPanelToggled>(_onFilterPanelToggled);
    on<AllCarsBrandChanged>(_onBrandChanged);
    on<AllCarsGearBoxChanged>(_onGearBoxChanged);
    on<AllCarsEngineChanged>(_onEngineChanged);
    on<AllCarsPriceRangeChanged>(_onPriceRangeChanged);
    on<AllCarsYearRangeChanged>(_onYearRangeChanged);
    on<AllCarsViewModeChanged>(_onViewModeChanged);
    on<AllCarsFilterRemoved>(_onFilterRemoved);
    on<AllCarsFiltersReset>(_onFiltersReset);
  }

  void _onSourceUpdated(
    AllCarsSourceUpdated event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    final brands = event.allCars
        .map((car) => car.singleCarInfoViewModel.brand)
        .toSet()
        .toList()
      ..sort();
    final gearBoxes = event.allCars
        .map((car) => car.singleCarInfoViewModel.gearBox)
        .toSet()
        .toList()
      ..sort();
    final engines = event.allCars
        .map((car) => car.singleCarInfoViewModel.engine)
        .toSet()
        .toList()
      ..sort();

    final nextState = state.copyWith(
      allCars: event.allCars,
      brands: brands,
      gearBoxes: gearBoxes,
      engines: engines,
    );

    emit(nextState.copyWith(filteredCars: _applyFilters(nextState)));
  }

  void _onSearchQueryChanged(
    AllCarsSearchQueryChanged event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    final nextState = state.copyWith(searchQuery: event.query.trim());
    emit(nextState.copyWith(filteredCars: _applyFilters(nextState)));
  }

  void _onFilterPanelToggled(
    AllCarsFilterPanelToggled event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    emit(state.copyWith(showFilters: !state.showFilters));
  }

  void _onBrandChanged(
    AllCarsBrandChanged event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    final nextState = state.copyWith(
      selectedBrand: event.brand,
      clearSelectedBrand: event.brand == null,
    );
    emit(nextState.copyWith(filteredCars: _applyFilters(nextState)));
  }

  void _onGearBoxChanged(
    AllCarsGearBoxChanged event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    final nextState = state.copyWith(
      selectedGearBox: event.gearBox,
      clearSelectedGearBox: event.gearBox == null,
    );
    emit(nextState.copyWith(filteredCars: _applyFilters(nextState)));
  }

  void _onEngineChanged(
    AllCarsEngineChanged event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    final nextState = state.copyWith(
      selectedEngine: event.engine,
      clearSelectedEngine: event.engine == null,
    );
    emit(nextState.copyWith(filteredCars: _applyFilters(nextState)));
  }

  void _onPriceRangeChanged(
    AllCarsPriceRangeChanged event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    final nextState = state.copyWith(priceRange: event.range);
    emit(nextState.copyWith(filteredCars: _applyFilters(nextState)));
  }

  void _onYearRangeChanged(
    AllCarsYearRangeChanged event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    final nextState = state.copyWith(yearRange: event.range);
    emit(nextState.copyWith(filteredCars: _applyFilters(nextState)));
  }

  void _onViewModeChanged(
    AllCarsViewModeChanged event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    emit(state.copyWith(viewMode: event.viewMode));
  }

  void _onFilterRemoved(
    AllCarsFilterRemoved event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    AllCarsFiltersState nextState = state;

    switch (event.filter) {
      case AllCarsRemovableFilter.brand:
        nextState = nextState.copyWith(clearSelectedBrand: true);
      case AllCarsRemovableFilter.gearBox:
        nextState = nextState.copyWith(clearSelectedGearBox: true);
      case AllCarsRemovableFilter.engine:
        nextState = nextState.copyWith(clearSelectedEngine: true);
    }

    emit(nextState.copyWith(filteredCars: _applyFilters(nextState)));
  }

  void _onFiltersReset(
    AllCarsFiltersReset event,
    Emitter<AllCarsFiltersState> emit,
  ) {
    final nextState = state.copyWith(
      searchQuery: '',
      clearSelectedBrand: true,
      clearSelectedGearBox: true,
      clearSelectedEngine: true,
      priceRange: AllCarsFiltersState.defaultPriceRange,
      yearRange: AllCarsFiltersState.defaultYearRange,
    );
    emit(nextState.copyWith(filteredCars: _applyFilters(nextState)));
  }

  List<CarViewModel> _applyFilters(AllCarsFiltersState state) {
    return state.allCars.where((car) {
      final info = car.singleCarInfoViewModel;

      if (state.searchQuery.isNotEmpty) {
        final searchable =
            '${info.brand} ${info.model} ${car.seria} ${info.color} ${info.engine}'
                .toLowerCase();
        if (!searchable.contains(state.searchQuery.toLowerCase())) {
          return false;
        }
      }

      if (state.selectedBrand != null && info.brand != state.selectedBrand) {
        return false;
      }

      if (state.selectedGearBox != null &&
          info.gearBox != state.selectedGearBox) {
        return false;
      }

      if (state.selectedEngine != null && info.engine != state.selectedEngine) {
        return false;
      }

      final price = _parsePrice(info.price);
      if (price < state.priceRange.start || price > state.priceRange.end) {
        return false;
      }

      final year = _parseYear(info.year);
      if (year < state.yearRange.start || year > state.yearRange.end) {
        return false;
      }

      return true;
    }).toList();
  }

  double _parsePrice(String price) {
    final cleaned = price.replaceAll(RegExp(r'[^\\d]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  int _parseYear(String year) => int.tryParse(year) ?? 2020;
}
