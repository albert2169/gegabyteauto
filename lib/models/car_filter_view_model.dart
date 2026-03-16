import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CarFilterViewModel extends Equatable {
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
    bool isRemovingOne = false,
  }) {
    return CarFilterViewModel(
      selectedBrand: isRemovingOne && selectedBrand == null
          ? null
          : selectedBrand ?? this.selectedBrand,
      selectedModel: isRemovingOne && selectedModel == null
          ? null
          : selectedModel ?? this.selectedModel,
      selectedSeria: isRemovingOne && selectedSeria == null
          ? null
          : selectedSeria ?? this.selectedSeria,
      selectedGearBox: isRemovingOne && selectedGearBox == null
          ? null
          : selectedGearBox ?? this.selectedGearBox,
      selectedEngine: isRemovingOne && selectedEngine == null
          ? null
          : selectedEngine ?? this.selectedEngine,
      priceRange: priceRange ?? this.priceRange,
      yearRange: yearRange ?? this.yearRange,
    );
  }

  @override
  List<Object?> get props => [
        selectedBrand,
        selectedModel,
        selectedSeria,
        selectedGearBox,
        selectedEngine,
        priceRange,
        yearRange,
      ];
}
