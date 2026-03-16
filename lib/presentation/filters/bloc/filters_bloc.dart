import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/app_constants/app_constants.dart';
import 'package:gegabyteauto/models/car_brand_view_model.dart';

import 'filters_event.dart';
import 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  late final List<CarBrandViewModel> _allBrandModels;

  FiltersBloc() : super(const FiltersState.initial()) {
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

    emit(state.copyWith(
      selectedBrand: event.brand,
      clearSelectedBrand: event.brand == null,
      clearSelectedModel: true,
      clearSelectedSeries: true,
      allModels: [...selectedBrandModel.models.map((model) => model.name)],
      availableSeries: const [],
    ));
  }

  void _onModelChanged(
    FiltersModelChanged event,
    Emitter<FiltersState> emit,
  ) {
    List<String> filteredSeries = [];

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
  ) {}

  void _onResetRequested(
    FiltersResetRequested event,
    Emitter<FiltersState> emit,
  ) {
    final allModels = _allBrandModels
        .expand((b) => b.models)
        .map((m) => m.name)
        .toSet()
        .toList()
      ..sort();
    final allSeries = _allBrandModels
        .expand((b) => b.models)
        .expand((m) => m.serias)
        .toSet()
        .toList()
      ..sort();

    emit(state.copyWith(
      clearSelectedBrand: true,
      clearSelectedModel: true,
      clearSelectedSeries: true,
      clearSelectedGearBox: true,
      clearSelectedEngine: true,
      priceRange: FiltersState.defaultPriceRange,
      yearRange: FiltersState.defaultYearRange,
      availableModels: allModels,
      availableSeries: allSeries,
    ));
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
