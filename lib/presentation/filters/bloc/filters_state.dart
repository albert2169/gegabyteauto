import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart';

export 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart'
    show LoadState;

enum RemovableFilter { brand, model, series, gearBox, engine }
   const _gearBoxes = ['Automatic', 'Manual', 'CVT'];
   const _engines = ['Gasoline', 'Diesel', 'Hybrid', 'Electric'];


class FiltersState extends Equatable {
  static const RangeValues defaultPriceRange = RangeValues(0, 250000);
  static const RangeValues defaultYearRange = RangeValues(2015, 2025);

  /// Current load state of the filters
  final LoadState loadState;

  /// Error message when loadState is error
  final String? errorMessage;

  final String? selectedBrand;
  final String? selectedModel;
  final String? selectedSeries;
  final String? selectedGearBox;
  final String? selectedEngine;
  final RangeValues priceRange;
  final RangeValues yearRange;

  final List<String> availableBrands;
  final List<String> availableModels; 
  final List<String> availableSeries; 
  final List<String> availableGearBoxes;
  final List<String> availableEngines;

  final List<String> allBrands;
  final List<String> allModels;
  final List<String> allSeries;

  const FiltersState({
    required this.loadState,
    this.errorMessage,
    required this.selectedBrand,
    required this.selectedModel,
    required this.selectedSeries,
    required this.selectedGearBox,
    required this.selectedEngine,
    required this.priceRange,
    required this.yearRange,
    required this.availableBrands,
    required this.availableModels,
    required this.availableSeries,
    required this.availableGearBoxes,
    required this.availableEngines,
    required this.allBrands,
    required this.allModels,
    required this.allSeries,
  });

  const FiltersState.initial()
      : loadState = LoadState.loaded,
        errorMessage = null,
        selectedBrand = null,
        selectedModel = null,
        selectedSeries = null,
        selectedGearBox = null,
        selectedEngine = null,
        priceRange = defaultPriceRange,
        yearRange = defaultYearRange,
        availableBrands = const [],
        availableModels = const [],
        availableSeries = const [],
        availableGearBoxes = _gearBoxes,
        availableEngines = _engines,
        allBrands = const [],
        allModels = const [],
        allSeries = const [];

  bool get isLoading => loadState == LoadState.loading;
  bool get isLoaded => loadState == LoadState.loaded;
  bool get isError => loadState == LoadState.error;

  bool get hasActiveFilters =>
      selectedBrand != null ||
      selectedModel != null ||
      selectedSeries != null ||
      selectedGearBox != null ||
      selectedEngine != null ||
      priceRange != defaultPriceRange ||
      yearRange != defaultYearRange;

  int get activeFilterCount {
    int count = 0;
    if (selectedBrand != null) count++;
    if (selectedModel != null) count++;
    if (selectedSeries != null) count++;
    if (selectedGearBox != null) count++;
    if (selectedEngine != null) count++;
    if (priceRange != defaultPriceRange) count++;
    if (yearRange != defaultYearRange) count++;
    return count;
  }

  FiltersState copyWith({
    LoadState? loadState,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? selectedBrand,
    bool clearSelectedBrand = false,
    String? selectedModel,
    bool clearSelectedModel = false,
    String? selectedSeries,
    bool clearSelectedSeries = false,
    String? selectedGearBox,
    bool clearSelectedGearBox = false,
    String? selectedEngine,
    bool clearSelectedEngine = false,
    RangeValues? priceRange,
    RangeValues? yearRange,
    List<String>? availableBrands,
    List<String>? availableModels,
    List<String>? availableSeries,
    List<String>? availableGearBoxes,
    List<String>? availableEngines,
    List<String>? allBrands,
    List<String>? allModels,
    List<String>? allSeries,
  }) {
    return FiltersState(
      loadState: loadState ?? this.loadState,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      selectedBrand:
          clearSelectedBrand ? null : (selectedBrand ?? this.selectedBrand),
      selectedModel:
          clearSelectedModel ? null : (selectedModel ?? this.selectedModel),
      selectedSeries:
          clearSelectedSeries ? null : (selectedSeries ?? this.selectedSeries),
      selectedGearBox: clearSelectedGearBox
          ? null
          : (selectedGearBox ?? this.selectedGearBox),
      selectedEngine:
          clearSelectedEngine ? null : (selectedEngine ?? this.selectedEngine),
      priceRange: priceRange ?? this.priceRange,
      yearRange: yearRange ?? this.yearRange,
      availableBrands: availableBrands ?? this.availableBrands,
      availableModels: availableModels ?? this.availableModels,
      availableSeries: availableSeries ?? this.availableSeries,
      availableGearBoxes: availableGearBoxes ?? this.availableGearBoxes,
      availableEngines: availableEngines ?? this.availableEngines,
      allBrands: allBrands ?? this.allBrands,
      allModels: allModels ?? this.allModels,
      allSeries: allSeries ?? this.allSeries,
    );
  }

  @override
  List<Object?> get props => [
        loadState,
        errorMessage,
        selectedBrand,
        selectedModel,
        selectedSeries,
        selectedGearBox,
        selectedEngine,
        priceRange,
        yearRange,
        availableBrands,
        availableModels,
        availableSeries,
        availableGearBoxes,
        availableEngines,
        allBrands,
        allModels,
        allSeries,
      ];
}
