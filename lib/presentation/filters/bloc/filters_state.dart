import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_filter_chip.dart';
import 'package:gegabyteauto/models/car_filter_view_model.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart';

export 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart'
    show LoadState;

enum RemovableFilter { brand, model, series, gearBox, engine }

const _gearBoxes = ['Ավտոմատ', 'Մեխանիկական', 'CVT'];
const _engines = ['Գազ', 'Դիզել', 'Հիբրիդ', 'Էլեկտրական'];

class FiltersState extends Equatable {
  static const RangeValues defaultPriceRange = RangeValues(0, 250000);
  static const RangeValues defaultYearRange = RangeValues(2015, 2025);
  final CarFilterViewModel carFilterViewModel;
  final LoadState loadState;
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
    this.carFilterViewModel = const CarFilterViewModel(),
    required this.loadState,
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

  const FiltersState.initial({
    this.availableBrands = const [],
    this.carFilterViewModel = const CarFilterViewModel(),
    String? brand,
    String? model,
    String? seria,
  })  : loadState = LoadState.loaded,
        selectedBrand = brand,
        selectedModel = model,
        selectedSeries = seria,
        selectedGearBox = null,
        selectedEngine = null,
        priceRange = defaultPriceRange,
        yearRange = defaultYearRange,
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

  List<CarFilterChip> get chips {
    final selectedChips = <CarFilterChip>[];
    if (selectedBrand != null) {
      selectedChips.add(
          CarFilterChip(chipName: selectedBrand!, type: FilterChipType.brand));
    }
    if (selectedModel != null) {
      selectedChips.add(
        CarFilterChip(chipName: selectedModel!, type: FilterChipType.model),
      );
    }
    if (selectedSeries != null) {
      selectedChips.add(
        CarFilterChip(chipName: selectedSeries!, type: FilterChipType.seria),
      );
    }
    if (selectedGearBox != null) {
      selectedChips.add(
        CarFilterChip(chipName: selectedGearBox!, type: FilterChipType.gearbox),
      );
    }
    if (selectedEngine != null) {
      selectedChips.add(
        CarFilterChip(chipName: selectedEngine!, type: FilterChipType.engine),
      );
    }
    return selectedChips;
  }

  FiltersState copyWith({
    LoadState? loadState,
    String? selectedBrand,
    String? selectedModel,
    String? selectedSeries,
    String? selectedGearBox,
    String? selectedEngine,
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
    bool isRemovingASingleChip = false,
    CarFilterViewModel? carFilterViewModel,
  }) {
    return FiltersState(
      carFilterViewModel: carFilterViewModel ?? this.carFilterViewModel,
      loadState: loadState ?? this.loadState,
      selectedBrand: isRemovingASingleChip && selectedBrand == null
          ? null
          : selectedBrand ?? this.selectedBrand,
      selectedModel: isRemovingASingleChip && selectedModel == null
          ? null
          : selectedModel ?? this.selectedModel,
      selectedSeries: isRemovingASingleChip && selectedSeries == null
          ? null
          : selectedSeries ?? this.selectedSeries,
      selectedGearBox: isRemovingASingleChip && selectedGearBox == null
          ? null
          : selectedGearBox ?? this.selectedGearBox,
      selectedEngine: isRemovingASingleChip && selectedEngine == null
          ? null
          : selectedEngine ?? this.selectedEngine,
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
        carFilterViewModel,
        loadState,
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
