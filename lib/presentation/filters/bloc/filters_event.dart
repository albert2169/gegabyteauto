import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_view_model.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object?> get props => [];
}

/// Load cars data to populate filter options
class FiltersLoadRequested extends FiltersEvent {
  final List<CarViewModel> cars;

  const FiltersLoadRequested({required this.cars});

  @override
  List<Object?> get props => [cars];
}

/// Brand selection changed
class FiltersBrandChanged extends FiltersEvent {
  final String? brand;

  const FiltersBrandChanged(this.brand);

  @override
  List<Object?> get props => [brand];
}

/// Model selection changed (depends on selected brand)
class FiltersModelChanged extends FiltersEvent {
  final String? model;

  const FiltersModelChanged(this.model);

  @override
  List<Object?> get props => [model];
}

/// Series selection changed (depends on selected model)
class FiltersSeriesChanged extends FiltersEvent {
  final String? series;

  const FiltersSeriesChanged(this.series);

  @override
  List<Object?> get props => [series];
}

/// Gearbox selection changed
class FiltersGearBoxChanged extends FiltersEvent {
  final String? gearBox;

  const FiltersGearBoxChanged(this.gearBox);

  @override
  List<Object?> get props => [gearBox];
}

/// Engine selection changed
class FiltersEngineChanged extends FiltersEvent {
  final String? engine;

  const FiltersEngineChanged(this.engine);

  @override
  List<Object?> get props => [engine];
}

/// Price range changed
class FiltersPriceRangeChanged extends FiltersEvent {
  final RangeValues range;

  const FiltersPriceRangeChanged(this.range);

  @override
  List<Object?> get props => [range];
}

/// Year range changed
class FiltersYearRangeChanged extends FiltersEvent {
  final RangeValues range;

  const FiltersYearRangeChanged(this.range);

  @override
  List<Object?> get props => [range];
}

/// Apply filters and navigate back
class FiltersApplyRequested extends FiltersEvent {
  const FiltersApplyRequested();
}

/// Reset all filters to defaults
class FiltersResetRequested extends FiltersEvent {
  const FiltersResetRequested();
}
