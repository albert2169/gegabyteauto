import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/app_constants/app_constants.dart';
import 'package:gegabyteauto/models/car_brand_view_model.dart';
import 'package:gegabyteauto/models/car_filter_chip.dart';
import 'package:gegabyteauto/models/car_filter_view_model.dart';

import 'filters_event.dart';
import 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  late FiltersState _initialFilterState;

  FiltersBloc() : super(const FiltersState.initial()) {
    on<RemoveASingleChipEvent>(_onRemoveASingleChipEvent);
    on<ApplyFiltersEvent>(_onApplyFiltersEvent);
    on<CloseWithoutApplyingEvent>(_onCloseWithoutApplyingEvent);
    on<FilterScreenActiveEvent>(_onFilterScreenActiveEvent);
    on<InitFiltersEvent>(_onInitFiltersEvent);
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

  Future<void> _onRemoveASingleChipEvent(
    RemoveASingleChipEvent event,
    Emitter<FiltersState> emit,
  ) async {
    final bool isSelectedBrand = event.filterChipType == FilterChipType.brand;
    final bool isSelectedModel = event.filterChipType == FilterChipType.model;
    final bool isSelectedSeria = event.filterChipType == FilterChipType.seria;
    final bool isSelectedgearbox =
        event.filterChipType == FilterChipType.gearbox;
    final bool isSelectedEngine = event.filterChipType == FilterChipType.engine;
    final carFilterViewModel = state.carFilterViewModel.copyWith(
      isRemovingOne: true,
      selectedBrand:
          isSelectedBrand ? null : state.carFilterViewModel.selectedBrand,
      selectedModel:
          isSelectedModel ? null : state.carFilterViewModel.selectedModel,
      selectedSeria:
          isSelectedSeria ? null : state.carFilterViewModel.selectedSeria,
      selectedEngine:
          isSelectedEngine ? null : state.carFilterViewModel.selectedEngine,
      selectedGearBox:
          isSelectedgearbox ? null : state.carFilterViewModel.selectedGearBox,
    );
    event.onFinish(carFilterViewModel);
    emit(
      state.copyWith(
        isRemovingASingleChip: true,
        selectedBrand: isSelectedBrand ? null : state.selectedBrand,
        selectedModel: isSelectedModel ? null : state.selectedModel,
        selectedSeries: isSelectedSeria ? null : state.selectedSeries,
        selectedEngine: isSelectedEngine ? null : state.selectedEngine,
        selectedGearBox: isSelectedgearbox ? null : state.selectedGearBox,
        carFilterViewModel: carFilterViewModel,
      ),
    );
  }

  Future<void> _onApplyFiltersEvent(
    ApplyFiltersEvent event,
    Emitter<FiltersState> emit,
  ) async {
    _initialFilterState = state;
  }

  Future<void> _onCloseWithoutApplyingEvent(
    CloseWithoutApplyingEvent event,
    Emitter<FiltersState> emit,
  ) async {
    emit(_initialFilterState);
  }

  Future<void> _onFilterScreenActiveEvent(
    FilterScreenActiveEvent event,
    Emitter<FiltersState> emit,
  ) async {
    _initialFilterState = state;
  }

  Future<void> _onInitFiltersEvent(
    InitFiltersEvent event,
    Emitter<FiltersState> emit,
  ) async {
    await _loadBrands();
    final availableBrands = [...AppConstants.brands.map((brand) => brand.name)];
    emit(state.copyWith(
      availableBrands: availableBrands,
    ));
  }

  void _onBrandChanged(
    FiltersBrandChanged event,
    Emitter<FiltersState> emit,
  ) {
    final selectedBrandModel = AppConstants.brands.where((brand) {
      return brand.name == event.brand;
    }).first;
    if (event.brand != null) {}
    emit(
      state.copyWith(
        selectedBrand: event.brand,
        availableModels: [
          ...selectedBrandModel.models.map((model) => model.name)
        ],
        availableSeries: const [],
        carFilterViewModel: state.carFilterViewModel.copyWith(
          selectedBrand: event.brand,
        ),
      ),
    );
  }

  void _onModelChanged(
    FiltersModelChanged event,
    Emitter<FiltersState> emit,
  ) {
    final availableSeries = AppConstants.brands
        .where((brand) {
          return brand.name == state.selectedBrand;
        })
        .first
        .models
        .where((model) => model.name == event.model)
        .first
        .serias;

    emit(state.copyWith(
      selectedModel: event.model,
      availableSeries: availableSeries,
      carFilterViewModel: state.carFilterViewModel.copyWith(
        selectedModel: event.model,
      ),
    ));
  }

  void _onSeriesChanged(
    FiltersSeriesChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      selectedSeries: event.series,
      carFilterViewModel: state.carFilterViewModel.copyWith(
        selectedSeria: event.series,
      ),
    ));
  }

  void _onGearBoxChanged(
    FiltersGearBoxChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      selectedGearBox: event.gearBox,
      carFilterViewModel: state.carFilterViewModel.copyWith(
        selectedGearBox: event.gearBox,
      ),
    ));
  }

  void _onEngineChanged(
    FiltersEngineChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      selectedEngine: event.engine,
      carFilterViewModel: state.carFilterViewModel.copyWith(
        selectedEngine: event.engine,
      ),
    ));
  }

  void _onPriceRangeChanged(
    FiltersPriceRangeChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      priceRange: event.range,
      carFilterViewModel: state.carFilterViewModel.copyWith(
        priceRange: event.range,
      ),
    ));
  }

  void _onYearRangeChanged(
    FiltersYearRangeChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      yearRange: event.range,
      carFilterViewModel: state.carFilterViewModel.copyWith(
        yearRange: event.range,
      ),
    ));
  }

  void _onApplyRequested(
    FiltersApplyRequested event,
    Emitter<FiltersState> emit,
  ) {}

  void _onResetRequested(
    FiltersResetRequested event,
    Emitter<FiltersState> emit,
  ) {
    final availableBrands = state.availableBrands;
    emit(FiltersState.initial(availableBrands: availableBrands));
  }

  Future<void> _loadBrands() async {
    final jsonString = await rootBundle.loadString(AppConstants.brandsJsonPath);
    final decoded = jsonDecode(jsonString) as List<dynamic>;

    final brands = decoded
        .map((e) => CarBrandViewModel.fromJson(e as Map<String, dynamic>))
        .toList();

    brands.sort((a, b) => a.name.compareTo(b.name));
    AppConstants.brands = brands;
  }
}
