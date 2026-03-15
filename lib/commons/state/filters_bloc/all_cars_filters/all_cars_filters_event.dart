import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/view_models/car_view_model.dart';

import 'all_cars_filters_state.dart';

abstract class AllCarsFiltersEvent extends Equatable {
  const AllCarsFiltersEvent();

  @override
  List<Object?> get props => [];
}

class AllCarsSourceUpdated extends AllCarsFiltersEvent {
  final List<CarViewModel> allCars;

  const AllCarsSourceUpdated({required this.allCars});

  @override
  List<Object?> get props => [allCars];
}

class AllCarsSearchQueryChanged extends AllCarsFiltersEvent {
  final String query;

  const AllCarsSearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class AllCarsFilterPanelToggled extends AllCarsFiltersEvent {
  const AllCarsFilterPanelToggled();
}

class AllCarsBrandChanged extends AllCarsFiltersEvent {
  final String? brand;

  const AllCarsBrandChanged(this.brand);

  @override
  List<Object?> get props => [brand];
}

class AllCarsGearBoxChanged extends AllCarsFiltersEvent {
  final String? gearBox;

  const AllCarsGearBoxChanged(this.gearBox);

  @override
  List<Object?> get props => [gearBox];
}

class AllCarsEngineChanged extends AllCarsFiltersEvent {
  final String? engine;

  const AllCarsEngineChanged(this.engine);

  @override
  List<Object?> get props => [engine];
}

class AllCarsPriceRangeChanged extends AllCarsFiltersEvent {
  final RangeValues range;

  const AllCarsPriceRangeChanged(this.range);

  @override
  List<Object?> get props => [range];
}

class AllCarsYearRangeChanged extends AllCarsFiltersEvent {
  final RangeValues range;

  const AllCarsYearRangeChanged(this.range);

  @override
  List<Object?> get props => [range];
}

class AllCarsViewModeChanged extends AllCarsFiltersEvent {
  final AllCarsViewMode viewMode;

  const AllCarsViewModeChanged(this.viewMode);

  @override
  List<Object?> get props => [viewMode];
}

class AllCarsFilterRemoved extends AllCarsFiltersEvent {
  final AllCarsRemovableFilter filter;

  const AllCarsFilterRemoved(this.filter);

  @override
  List<Object?> get props => [filter];
}

class AllCarsFiltersReset extends AllCarsFiltersEvent {
  const AllCarsFiltersReset();
}
