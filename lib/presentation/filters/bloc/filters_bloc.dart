import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/models/car_view_model.dart';

import 'filters_event.dart';
import 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final List<CarViewModel> _allCars = [];

  FiltersBloc() : super(const FiltersState.initial()) {
    on<FiltersLoadRequested>(_onLoadRequested);
    on<FiltersBrandChanged>(_onBrandChanged);
    on<FiltersModelChanged>(_onModelChanged);
    on<FiltersSeriesChanged>(_onSeriesChanged);
    on<FiltersGearBoxChanged>(_onGearBoxChanged);
    on<FiltersEngineChanged>(_onEngineChanged);
    on<FiltersPriceRangeChanged>(_onPriceRangeChanged);
    on<FiltersYearRangeChanged>(_onYearRangeChanged);
    on<FiltersApplyRequested>(_onApplyRequested);
    on<FiltersResetRequested>(_onResetRequested);
  }

  void _onLoadRequested(
    FiltersLoadRequested event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(loadState: LoadState.loading));

    try {
      _allCars.clear();
      _allCars.addAll(event.cars);
      final brands = event.cars
          .map((car) => car.singleCarInfoViewModel.brand)
          .where((brand) => brand.isNotEmpty)
          .toSet()
          .toList()
        ..sort();

      final models = event.cars
          .map((car) => car.singleCarInfoViewModel.model)
          .where((model) => model.isNotEmpty)
          .toSet()
          .toList()
        ..sort();

      final series = event.cars
          .map((car) => car.seria)
          .where((s) => s.isNotEmpty)
          .toSet()
          .toList()
        ..sort();

      final gearBoxes = event.cars
          .map((car) => car.singleCarInfoViewModel.gearBox)
          .where((gb) => gb.isNotEmpty)
          .toSet()
          .toList()
        ..sort();

      final engines = event.cars
          .map((car) => car.singleCarInfoViewModel.engine)
          .where((e) => e.isNotEmpty)
          .toSet()
          .toList()
        ..sort();

      emit(state.copyWith(
        loadState: LoadState.loaded,
        availableBrands: brands,
        availableModels: models,
        availableSeries: series,
        availableGearBoxes: gearBoxes,
        availableEngines: engines,
        allBrands: brands,
        allModels: models,
        allSeries: series,
      ));
    } catch (e) {
      emit(state.copyWith(
        loadState: LoadState.error,
        errorMessage: 'Failed to load filter options',
      ));
    }
  }

  void _onBrandChanged(
    FiltersBrandChanged event,
    Emitter<FiltersState> emit,
  ) {
    List<String> filteredModels = [];
    if (event.brand != null) {
      filteredModels = _allCars
          .where((car) => car.singleCarInfoViewModel.brand == event.brand)
          .map((car) => car.singleCarInfoViewModel.model)
          .where((model) => model.isNotEmpty)
          .toSet()
          .toList()
        ..sort();
    } else {
      filteredModels = _allCars
          .map((car) => car.singleCarInfoViewModel.model)
          .where((model) => model.isNotEmpty)
          .toSet()
          .toList()
        ..sort();
    }

    emit(state.copyWith(
      selectedBrand: event.brand,
      clearSelectedBrand: event.brand == null,
      clearSelectedModel: true,
      clearSelectedSeries: true,
      availableModels: filteredModels,
      availableSeries: const [],
    ));
  }

  void _onModelChanged(
    FiltersModelChanged event,
    Emitter<FiltersState> emit,
  ) {
    List<String> filteredSeries = [];
    if (event.model != null) {
      filteredSeries = _allCars
          .where((car) => car.singleCarInfoViewModel.model == event.model)
          .map((car) => car.seria)
          .where((s) => s.isNotEmpty)
          .toSet()
          .toList()
        ..sort();
    } else if (state.selectedBrand != null) {
      filteredSeries = _allCars
          .where(
              (car) => car.singleCarInfoViewModel.brand == state.selectedBrand)
          .map((car) => car.seria)
          .where((s) => s.isNotEmpty)
          .toSet()
          .toList()
        ..sort();
    }

    emit(state.copyWith(
      selectedModel: event.model,
      clearSelectedModel: event.model == null,
      clearSelectedSeries: true,
      availableSeries: filteredSeries,
    ));
  }

  void _onSeriesChanged(
    FiltersSeriesChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      selectedSeries: event.series,
      clearSelectedSeries: event.series == null,
    ));
  }

  void _onGearBoxChanged(
    FiltersGearBoxChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      selectedGearBox: event.gearBox,
      clearSelectedGearBox: event.gearBox == null,
    ));
  }

  void _onEngineChanged(
    FiltersEngineChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      selectedEngine: event.engine,
      clearSelectedEngine: event.engine == null,
    ));
  }

  void _onPriceRangeChanged(
    FiltersPriceRangeChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(priceRange: event.range));
  }

  void _onYearRangeChanged(
    FiltersYearRangeChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(yearRange: event.range));
  }

  void _onApplyRequested(
    FiltersApplyRequested event,
    Emitter<FiltersState> emit,
  ) {
  }

  void _onResetRequested(
    FiltersResetRequested event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      clearSelectedBrand: true,
      clearSelectedModel: true,
      clearSelectedSeries: true,
      clearSelectedGearBox: true,
      clearSelectedEngine: true,
      priceRange: FiltersState.defaultPriceRange,
      yearRange: FiltersState.defaultYearRange,
      availableModels: state.allModels,
      availableSeries: state.allSeries,
    ));
  }
}
