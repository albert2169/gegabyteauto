import 'package:equatable/equatable.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_state.dart';

import 'cars_state.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object?> get props => [];
}

/// Request to load cars
class CarsLoadRequested extends CarsEvent {
  const CarsLoadRequested();
}

/// Request to refresh cars
class CarsRefreshRequested extends CarsEvent {
  const CarsRefreshRequested();
}

/// Change view mode (list, grid, reels)
class CarsViewModeChanged extends CarsEvent {
  final CarsViewMode viewMode;

  const CarsViewModeChanged(this.viewMode);

  @override
  List<Object?> get props => [viewMode];
}

/// Search query changed
class CarsSearchQueryChanged extends CarsEvent {
  final String query;

  const CarsSearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

/// Apply filters from filters screen
class CarsFiltersApplied extends CarsEvent {
  final FiltersState filters;

  const CarsFiltersApplied(this.filters);

  @override
  List<Object?> get props => [filters];
}

/// Clear all filters
class CarsFiltersClear extends CarsEvent {
  const CarsFiltersClear();
}
