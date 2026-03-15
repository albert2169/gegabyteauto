import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/view_models/car_view_model.dart';

enum AllCarsViewMode { list, grid, reels }

enum AllCarsRemovableFilter { brand, gearBox, engine }

class AllCarsFiltersState extends Equatable {
  static const RangeValues defaultPriceRange = RangeValues(0, 250000);
  static const RangeValues defaultYearRange = RangeValues(2015, 2025);

  final bool showFilters;
  final AllCarsViewMode viewMode;
  final String searchQuery;
  final String? selectedBrand;
  final String? selectedGearBox;
  final String? selectedEngine;
  final RangeValues priceRange;
  final RangeValues yearRange;
  final List<CarViewModel> allCars;
  final List<CarViewModel> filteredCars;
  final List<String> brands;
  final List<String> gearBoxes;
  final List<String> engines;

  const AllCarsFiltersState({
    required this.showFilters,
    required this.viewMode,
    required this.searchQuery,
    required this.selectedBrand,
    required this.selectedGearBox,
    required this.selectedEngine,
    required this.priceRange,
    required this.yearRange,
    required this.allCars,
    required this.filteredCars,
    required this.brands,
    required this.gearBoxes,
    required this.engines,
  });

  const AllCarsFiltersState.initial()
      : showFilters = false,
        viewMode = AllCarsViewMode.list,
        searchQuery = '',
        selectedBrand = null,
        selectedGearBox = null,
        selectedEngine = null,
        priceRange = defaultPriceRange,
        yearRange = defaultYearRange,
        allCars = const [],
        filteredCars = const [],
        brands = const [],
        gearBoxes = const [],
        engines = const [];

  bool get hasActiveFilters =>
      searchQuery.isNotEmpty ||
      selectedBrand != null ||
      selectedGearBox != null ||
      selectedEngine != null ||
      priceRange != defaultPriceRange ||
      yearRange != defaultYearRange;

  AllCarsFiltersState copyWith({
    bool? showFilters,
    AllCarsViewMode? viewMode,
    String? searchQuery,
    String? selectedBrand,
    bool clearSelectedBrand = false,
    String? selectedGearBox,
    bool clearSelectedGearBox = false,
    String? selectedEngine,
    bool clearSelectedEngine = false,
    RangeValues? priceRange,
    RangeValues? yearRange,
    List<CarViewModel>? allCars,
    List<CarViewModel>? filteredCars,
    List<String>? brands,
    List<String>? gearBoxes,
    List<String>? engines,
  }) {
    return AllCarsFiltersState(
      showFilters: showFilters ?? this.showFilters,
      viewMode: viewMode ?? this.viewMode,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedBrand:
          clearSelectedBrand ? null : (selectedBrand ?? this.selectedBrand),
      selectedGearBox: clearSelectedGearBox
          ? null
          : (selectedGearBox ?? this.selectedGearBox),
      selectedEngine:
          clearSelectedEngine ? null : (selectedEngine ?? this.selectedEngine),
      priceRange: priceRange ?? this.priceRange,
      yearRange: yearRange ?? this.yearRange,
      allCars: allCars ?? this.allCars,
      filteredCars: filteredCars ?? this.filteredCars,
      brands: brands ?? this.brands,
      gearBoxes: gearBoxes ?? this.gearBoxes,
      engines: engines ?? this.engines,
    );
  }

  @override
  List<Object?> get props => [
        showFilters,
        viewMode,
        searchQuery,
        selectedBrand,
        selectedGearBox,
        selectedEngine,
        priceRange,
        yearRange,
        allCars,
        filteredCars,
        brands,
        gearBoxes,
        engines,
      ];
}
