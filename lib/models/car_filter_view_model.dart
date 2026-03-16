import 'package:flutter/material.dart';

class CarFilterViewModel {
  final String? selectedBrand;
  final String? selectedModel;
  final String? selectedSeria;
  final String? selectedGearBox;
  final String? selectedEngine;
  final RangeValues? priceRange;
  final RangeValues? yearRange;

  const CarFilterViewModel({
    this.selectedBrand,
    this.selectedModel,
    this.selectedSeria,
    this.selectedGearBox,
    this.selectedEngine,
    this.priceRange,
    this.yearRange,
  });

  CarFilterViewModel copyWith({
    String? selectedBrand,
    String? selectedModel,
    String? selectedSeria,
    String? selectedGearBox,
    String? selectedEngine,
    RangeValues? priceRange,
    RangeValues? yearRange,
  }) {
    return CarFilterViewModel(
      selectedBrand: selectedBrand ?? this.selectedBrand,
      selectedModel: selectedModel ?? this.selectedModel,
      selectedSeria: selectedSeria ?? this.selectedSeria,
      selectedGearBox: selectedGearBox ?? this.selectedGearBox,
      selectedEngine: selectedEngine ?? this.selectedEngine,
      priceRange: priceRange ?? this.priceRange,
      yearRange: yearRange ?? this.yearRange,
    );
  }
}
