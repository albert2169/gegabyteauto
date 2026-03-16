import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object?> get props => [];
}

class InitFiltersEvent extends FiltersEvent {
  const InitFiltersEvent();
}

class FilterScreenActiveEvent extends FiltersEvent {
  const FilterScreenActiveEvent();
}

class FiltersBrandChanged extends FiltersEvent {
  final String? brand;

  const FiltersBrandChanged(this.brand);

  @override
  List<Object?> get props => [brand];
}

class FiltersModelChanged extends FiltersEvent {
  final String? model;

  const FiltersModelChanged(this.model);

  @override
  List<Object?> get props => [model];
}

class FiltersSeriesChanged extends FiltersEvent {
  final String? series;

  const FiltersSeriesChanged(this.series);

  @override
  List<Object?> get props => [series];
}

class FiltersGearBoxChanged extends FiltersEvent {
  final String? gearBox;

  const FiltersGearBoxChanged(this.gearBox);

  @override
  List<Object?> get props => [gearBox];
}

class FiltersEngineChanged extends FiltersEvent {
  final String? engine;

  const FiltersEngineChanged(this.engine);

  @override
  List<Object?> get props => [engine];
}

class FiltersPriceRangeChanged extends FiltersEvent {
  final RangeValues range;

  const FiltersPriceRangeChanged(this.range);

  @override
  List<Object?> get props => [range];
}

class FiltersYearRangeChanged extends FiltersEvent {
  final RangeValues range;

  const FiltersYearRangeChanged(this.range);

  @override
  List<Object?> get props => [range];
}

class FiltersApplyRequested extends FiltersEvent {
  const FiltersApplyRequested();
}

class FiltersResetRequested extends FiltersEvent {
  const FiltersResetRequested();
}
